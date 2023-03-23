-- 16_정규화.sql
/*
    # 정규화 (Normalization)
    - 필요한 데이터들을 데이터베이스에 적합한 구조로 변환하는 과정
    - 정규화가 되지 않은 데이터들은 이상현상을 일으킨다
    
    
    # 제 1정규형 (1NF, Normarlization Form)
    - 각 컬럼이 하나의 값만 가져야 한다
    - 하나의 컬럼 데이터들은 같은 타입을 가져야 한다 (도메인 무결성)
    - 각 컬럼을 유일하게 구분할 수 있어야 한다
    - 컬럼의 순서가 상관없어야 한다
    
    # 1NF를 만족시키지 못한 형태
    커피 테이블
        
    커피이름    / 커피가격 / 커피크기 / 커피온도
    ------------------------------------------------------
    아메리카노   8000        T,G,V              H,I
        
     # 1NF를 만족시킨 상태 (ver.1)
     커피 가격 테이블
     --------------------------------
     아메리카노   8000
     카페라떼       7000
     
     커피별 컵 사이즈 테이블
     --------------------------------
     아메리카노  Tall
     아메리카노  Grande
     아메리카노  Venti
     카페라떼      Tall
     카페라떼      Venti
     
     커피별 가능 온도 테이블
     --------------------------------
     아메리카노 Hot
     아메리카노 Ice
     
     
     # 1NF를 만족시킨 상태 (ver.2)
     커피이름    / 커피가격 / Tall / Grande / Venti / Hot / Ice
        ---------------------------------------------------------------------
        아메리카노   8000      O         O           O           O       O
        카페라떼       7000      O         O           X           O       O
        
        
    # 제 2정규형 이후의 정규형들은 궁금하다면 인터넷 검색을 통해 해결합시다
        (보통은 직관적으로 해결 됩니다)
  
    # 1:N 관계 해결 방법
    - 각 개체들이 1:N 관계인 경우 외래키를 통한 관계 설정을 해주면 된다
    - 1:N 관계는 관계형 데이터베이스에서는 아주 바람직한 관계라고 할 수 있다
        
    # N:N 관계 해결 방법
    1. N:N 관계의 개체 사이에 테이블을 하나 추가해 두 개의 1:N 관계로 만들 수 있다
    - 물리적 저장 공간을 절약할 수 있다 (데이터 중복을 최소화)
    - 조회 시 조인이 많이 발생하기 때문에 조회가 느려질 우려가 있다
    
    ex) 영화관
          * 영화 정보
         movie_id(PK) | movie_name | director | grade
         
         * 회원 영화 관람 내역
        member_id(FK) | movie_id(FK)
    
         * 영화 관람객 정보 (회원)
        member_id(PK) | member_name | age | join_date |  봤던 영화(FK)
        
    2. 두 개의 테이블을 하나로 합친다
    - 물리적 저장 공간을 낭비하게 된다 (중복 데이터가 늘어난다)
    - 대신 조회 속도가 매우 빠르다
    
     id(PK) | movie_name | ... | member_id | member_name | ...
*/


/*
    ※ 다대다 관계의 두 엔티티를 생각해보고 1번 방식으로 테이블을 설계하여 생성해보세요
    동물원
    
    사육사
    zookeeper_id | zkp_name | field_id | department_name
    1001                         마동석          1         대동물
    1002                         김종국          2         대동물
    1003                        이광수           3         대동물
    1004                        전소민           4        소동물
    1005                        유재석           5         파충류관
    1006                        하동훈           6         아쿠아리움
    
    
    돌보미
    zookeepr_id | animal_id
    1001                10
    1002                11
    1003                30
    1004                40
    1005                50
    1006                60
    
    
     동물
    animal_id | ani_species | ani_name | ani_age | ani_classification | field_id
    10                 코끼리                  코순이              5                   포유류                    1
    11                 코끼리                  코돌이              4                   포유류                    1
    20                 호랑이                  호치                   2                   포유류                    2
    30                 기린                      점박이              8                   포유류                    3
    40                 토끼                      새초미              1                     포유류                   4
    50                 메뚜기                 메두사               2                     파충류                 5
    60                 돌고래                   하하                10                     포유류                 6 
    70                반달가슴곰           송강                3개월             포유류                     7
    
    
   우리 담당
  field_id(FK) | zookeeper_id(FK)
    
    우리
    field_id | field_name |
    1                대동물관A                            
    2                대동물관B
    3               대동물관C
    4               소동물관
    5               파충류관
    6              아쿠아리움
    7              성장관
    
    우리 소속
    field_id | animal_id  
    1                   10
    1                   11
    2                   20
    3                   30
    4                   40
    5                   50
    6                   60 
*/


CREATE TABLE zookeepers (
     zookeeper_id NUMBER(4)
        CONSTRAINT zookeeper_id_pk PRIMARY KEY
        CONSTRAINT zookeeper_id_nn NOT NULL,
     zkp_name VARCHAR2 (10),
     field_id NUMBER(3)
        CONSTRAINT fieldz_id_nn NOT NULL,
     department_name VARCHAR2 (30)
);


CREATE TABLE manageAnimals (
    zookeeper_id NUMBER(4)
         CONSTRAINT zkp_id_fk REFERENCES zookeepers (zookeeper_id),
      animal_id NUMBER(4)
        CONSTRAINT animal_id_fk REFERENCES animals (animal_id)
);
SELECT * FROM manageAnimals;


CREATE TABLE animals (
     animal_id NUMBER(4)
        CONSTRAINT animal_id_nn NOT NULL
        CONSTRAINT animal_id_pk PRIMARY KEY,
     ani_species VARCHAR2 (50),
     ani_name   VARCHAR2 (10) DEFAULT 'null',
     ani_age CHAR(10)
        CONSTRAINT ani_age_nn NOT NULL,
     ani_classification VARCHAR2 (10)
         CONSTRAINT ani_classification_nn NOT NULL,
    field_id NUMBER(3)
        CONSTRAINT fielda_id_nn NOT NULL
);
        
CREATE TABLE animalsFields (
    field_id NUMBER(3)
        CONSTRAINT field_id_nn NOT NULL
        CONSTRAINT field_id_pk PRIMARY KEY,
     field_name VARCHAR2 (30) DEFAULT 'null'
);


INSERT INTO zookeepers( zookeeper_id, zkp_name, field_id, department_name) VALUES(1001, '마동석', 1, '대동물');
INSERT INTO zookeepers VALUES(1002, '김종국', 2, '대동물');
INSERT INTO zookeepers VALUES(1003, '이광수', 3, '대동물');
INSERT INTO zookeepers VALUES(1004, '전소민', 4, '소동물');
INSERT INTO zookeepers VALUES(1005, '유재석', 5, '파충류관');
INSERT INTO zookeepers VALUES(1006, '하동훈', 6, '아쿠아리움');
INSERT INTO zookeepers VALUES(1007, '지석진', 4, '소동물');

INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1001,10);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1001,11);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1002,20);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1003,20);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1007,70);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1007,71);
INSERT INTO manageAnimals( zookeeper_id, animal_id) VALUES(1007,72);


INSERT INTO animals( animal_id, ani_species, ani_name, ani_age, ani_classification, field_id) VALUES(10, '코끼리', '코순이', '5살', '포유류', 1);
INSERT INTO animals VALUES(11, '코끼리', '코돌이', '4살', '포유류', 1);
INSERT INTO animals VALUES(20, '호랑이', '호치', '4살', '포유류', 1);
INSERT INTO animals VALUES(30, '기린', '점박이', '8살', '포유류', 2);
INSERT INTO animals VALUES(30, '기린', '점남이', '8살', '포유류', 2);
INSERT INTO animals VALUES(40, '토끼', '새초미', '1살', '포유류', 4);
INSERT INTO animals VALUES(50, '메뚜기', '메두사', '2살', '파충류', 5);
INSERT INTO animals VALUES(51, '메뚜기', '메리', '2살', '파충류', 5);
INSERT INTO animals VALUES(60, '돌고래', '하하', '10살', '포유류', 6);
INSERT INTO animals VALUES(61, '돌고래', '하로로', '8살', '포유류', 6);
INSERT INTO animals VALUES(70, '반달가슴곰', '송강', '3개월', '포유류', 7);
INSERT INTO animals VALUES(71, '반달가슴곰', '은우', '2개월', '포유류', 7);
INSERT INTO animals VALUES(72, '반달가슴곰', '도현', '2개월', '포유류', 7);


INSERT INTO animalsFields(field_id, field_name) VALUES (1, '대동물관A');
INSERT INTO animalsFields(field_id, field_name) VALUES (2, '대동물관B');
INSERT INTO animalsFields(field_id, field_name) VALUES (3, '대동물관C');
INSERT INTO animalsFields(field_id, field_name) VALUES (4, '소동물관');
INSERT INTO animalsFields(field_id, field_name) VALUES (5, '파충류관');
INSERT INTO animalsFields(field_id, field_name) VALUES (6, '아쿠아리움');
INSERT INTO animalsFields(field_id, field_name) VALUES (7, '성장관');


SELECT * FROM zookeepers;
SELECT * FROM animals;
SELECT * FROM animalsFields;


-- 사육사 + 담당동물 + 구역
SELECT
    z.zookeeper_id,
    z.zkp_name,
    a.ani_name
FROM
    zookeepers z,
    animals a
WHERE
   z.animal_id = a.animal_id;
   
   
-- 동물 + 담당구역
SELECT
    f.field_name,
    a.ani_name
FROM
    animals a,
    animalsfields f
WHERE
    a.field_id = f.field_id;
    

SELECT
    zkp_name,
    animal_id,
    ani_name
FROM
    manageAnimals
    INNER JOIN zookeepers USING (zookeeper_id)
    INNER JOIN animals USING (animal_id);