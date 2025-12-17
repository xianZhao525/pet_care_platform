package com.petplatform.config;

import com.petplatform.dao.PetRepository;
import com.petplatform.dao.UserRepository;
import com.petplatform.entity.Pet;
import com.petplatform.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder; // 导入正确的类
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PetRepository petRepository;

    @Autowired
    private PasswordEncoder passwordEncoder; // 注入 Spring 的 PasswordEncoder

    @Override
    public void run(String... args) {
        // 初始化管理员用户
        if (userRepository.findByUsername("admin").isEmpty()) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(passwordEncoder.encode("admin123")); // 使用注入的 PasswordEncoder
            admin.setEmail("admin@petplatform.com");
            admin.setPhone("13800138000");
            admin.setRole(User.UserRole.ADMIN);
            userRepository.save(admin);

            // 初始化普通用户
            User user1 = new User();
            user1.setUsername("user1");
            user1.setPassword(passwordEncoder.encode("user123"));
            user1.setEmail("user1@example.com");
            user1.setPhone("13900139000");
            userRepository.save(user1);

            // 初始化宠物数据
            Pet pet1 = new Pet();
            pet1.setName("小白");
            pet1.setType(Pet.PetType.DOG);
            pet1.setBreed("比熊犬");
            pet1.setAge(2);
            pet1.setGender("公");
            pet1.setColor("白色");
            pet1.setDescription("活泼可爱的小比熊，非常亲人");
            pet1.setHealthStatus("健康，已接种疫苗");
            pet1.setVaccination("已接种狂犬病疫苗");
            pet1.setOwner(admin);
            petRepository.save(pet1);

            Pet pet2 = new Pet();
            pet2.setName("小花");
            pet2.setType(Pet.PetType.CAT);
            pet2.setBreed("橘猫");
            pet2.setAge(1);
            pet2.setGender("母");
            pet2.setColor("橘色");
            pet2.setDescription("温顺的橘猫，喜欢被抚摸");
            pet2.setHealthStatus("健康，已绝育");
            pet2.setVaccination("已接种猫三联疫苗");
            pet2.setOwner(user1);
            petRepository.save(pet2);

            System.out.println("初始化数据完成！");
            System.out.println("管理员账号：admin / admin123");
            System.out.println("普通用户：user1 / user123");
        }
    }
}