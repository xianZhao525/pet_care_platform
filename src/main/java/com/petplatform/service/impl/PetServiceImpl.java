package main.java.com.petplatform.service.impl;

import com.petplatform.dao.PetRepository;
import com.petplatform.entity.Pet;
import com.petplatform.dto.PetDTO;
import com.petplatform.service.PetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class PetServiceImpl implements PetService {

    @Autowired
    private PetRepository petRepository;

    private final String uploadDir = "uploads/pets/";

    @Override
    public Pet addPet(PetDTO petDTO) {
        Pet pet = new Pet();
        convertDTOToEntity(petDTO, pet);

        // 处理图片上传
        if (petDTO.getImageFile() != null && !petDTO.getImageFile().isEmpty()) {
            String imageUrl = saveImage(petDTO.getImageFile());
            pet.setImageUrl(imageUrl);
        }

        return petRepository.save(pet);
    }

    @Override
    public Pet updatePet(Long petId, PetDTO petDTO) {
        Pet pet = getPetById(petId);
        convertDTOToEntity(petDTO, pet);

        // 处理图片更新
        if (petDTO.getImageFile() != null && !petDTO.getImageFile().isEmpty()) {
            // 删除旧图片
            deleteOldImage(pet.getImageUrl());
            // 保存新图片
            String imageUrl = saveImage(petDTO.getImageFile());
            pet.setImageUrl(imageUrl);
        }

        return petRepository.save(pet);
    }

    @Override
    public void deletePet(Long petId) {
        Pet pet = getPetById(petId);
        // 删除图片文件
        deleteOldImage(pet.getImageUrl());
        petRepository.delete(pet);
    }

    @Override
    public Pet getPetById(Long petId) {
        return petRepository.findById(petId)
                .orElseThrow(() -> new RuntimeException("宠物不存在"));
    }

    @Override
    public List<Pet> getAllPets() {
        return petRepository.findAll();
    }

    @Override
    public Page<Pet> getPetsByPage(Pageable pageable) {
        return petRepository.findAll(pageable);
    }

    @Override
    public List<Pet> searchPets(String keyword, String type) {
        if (type == null || type.isEmpty()) {
            return petRepository.searchPets(keyword);
        } else {
            Pet.PetType petType = Pet.PetType.valueOf(type.toUpperCase());
            return petRepository.searchPetsByType(keyword, petType);
        }
    }

    @Override
    public List<Pet> getAvailablePets() {
        return petRepository.findByStatus(Pet.PetStatus.AVAILABLE);
    }

    @Override
    public List<Pet> getRecentPets(int limit) {
        Pageable pageable = PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "createTime"));
        return petRepository.findRecentAvailablePets(pageable);
    }

    @Override
    public void changePetStatus(Long petId, String status) {
        Pet pet = getPetById(petId);
        pet.setStatus(Pet.PetStatus.valueOf(status.toUpperCase()));
        petRepository.save(pet);
    }

    @Override
    public long getPetCount() {
        return petRepository.count();
    }

    @Override
    public Map<String, Long> getPetStatistics() {
        Map<String, Long> statistics = new HashMap<>();
        statistics.put("total", petRepository.count());
        statistics.put("available", petRepository.countAvailablePets());

        // 按类型统计
        List<Object[]> typeCounts = petRepository.countPetsByType();
        for (Object[] result : typeCounts) {
            String type = (String) result[0];
            Long count = (Long) result[1];
            statistics.put(type.toLowerCase(), count);
        }

        return statistics;
    }

    private void convertDTOToEntity(PetDTO dto, Pet pet) {
        pet.setName(dto.getName());
        pet.setType(Pet.PetType.valueOf(dto.getType().toUpperCase()));
        pet.setBreed(dto.getBreed());
        pet.setAge(dto.getAge());
        if (dto.getGender() != null) {
            pet.setGender(Pet.PetGender.valueOf(dto.getGender().toUpperCase()));
        }
        pet.setColor(dto.getColor());
        pet.setDescription(dto.getDescription());
        pet.setHealthStatus(dto.getHealthStatus());
        pet.setVaccination(dto.getVaccination());
        pet.setSterilized(dto.getSterilized());
    }

    private String saveImage(MultipartFile imageFile) {
        try {
            // 创建上传目录
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 生成唯一文件名
            String originalFilename = imageFile.getOriginalFilename();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFilename = UUID.randomUUID().toString() + fileExtension;

            // 保存文件
            File file = new File(uploadDir + newFilename);
            imageFile.transferTo(file);

            return "/uploads/pets/" + newFilename;
        } catch (IOException e) {
            throw new RuntimeException("图片保存失败", e);
        }
    }

    private void deleteOldImage(String imageUrl) {
        if (imageUrl != null && !imageUrl.isEmpty() &&
                !imageUrl.equals("/static/images/pets/default-pet.jpg")) {
            String filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
            File file = new File(uploadDir + filename);
            if (file.exists()) {
                file.delete();
            }
        }
    }
}