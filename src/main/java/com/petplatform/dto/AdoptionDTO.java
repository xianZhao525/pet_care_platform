package com.petplatform.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdoptionDTO {

    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @NotNull(message = "宠物ID不能为空")
    private Long petId;

    @NotBlank(message = "申请理由不能为空")
    @Size(max = 1000, message = "申请理由不能超过1000个字符")
    private String reason;

    @Min(value = 1, message = "家庭成员数至少为1")
    @Max(value = 20, message = "家庭成员数过多")
    private Integer familyMembers;

    private Boolean hasPetExperience;

    @NotBlank(message = "住房类型不能为空")
    private String houseType; // 公寓/别墅/平房等

    @NotBlank(message = "联系电话不能为空")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String contactPhone;

    @NotBlank(message = "联系地址不能为空")
    @Size(max = 200, message = "地址过长")
    private String contactAddress;
}