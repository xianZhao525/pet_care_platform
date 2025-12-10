USE pet_care_platform;

-- 插入管理员用户
INSERT INTO
    users (
        username,
        password,
        email,
        phone,
        role
    )
VALUES (
        'admin',
        '$2a$10$ABC123...',
        'admin@petplatform.com',
        '13800138000',
        'ADMIN'
    ),
    (
        'user1',
        '$2a$10$DEF456...',
        'user1@example.com',
        '13900139000',
        'USER'
    ),
    (
        'user2',
        '$2a$10$GHI789...',
        'user2@example.com',
        '13700137000',
        'USER'
    );

-- 插入宠物数据
INSERT INTO
    pets (
        name,
        type,
        breed,
        age,
        gender,
        color,
        description,
        health_status
    )
VALUES (
        '小白',
        'DOG',
        '比熊犬',
        2,
        '公',
        '白色',
        '活泼可爱的小比熊，已经绝育，非常亲人',
        '健康，已接种疫苗'
    ),
    (
        '小花',
        'CAT',
        '橘猫',
        1,
        '母',
        '橘色',
        '温顺的橘猫，喜欢被抚摸，会用猫砂',
        '健康，已绝育'
    ),
    (
        '豆豆',
        'DOG',
        '泰迪',
        3,
        '公',
        '棕色',
        '聪明伶俐的泰迪，会简单的指令',
        '健康，定期驱虫'
    ),
    (
        '布丁',
        'CAT',
        '英短',
        2,
        '母',
        '灰色',
        '安静优雅的英国短毛猫，适合家庭饲养',
        '健康，已接种疫苗'
    ),
    (
        '乐乐',
        'RABBIT',
        '垂耳兔',
        1,
        '公',
        '白色',
        '可爱的垂耳兔，性格温和，容易饲养',
        '健康'
    );