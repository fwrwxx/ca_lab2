cmake_minimum_required(VERSION 3.10)
project(lab2_make C)

# Пошук заголовків в include
include_directories(${CMAKE_SOURCE_DIR}/include)

set(SRC_FILES
    src/math.c
    src/main.c
)

# бібліотека (можна вибирати STATIC або SHARED)
add_library(calc STATIC src/math.c)
# Якщо хочеш shared, використай:
# add_library(calc SHARED src/math.c)

# Створити виконуваний файл, який лінкується з бібліотекою
add_executable(app src/main.c)
target_link_libraries(app PRIVATE calc)

# Невелика опція для позиційно-незалежного коду для shared lib
set_target_properties(calc PROPERTIES POSITION_INDEPENDENT_CODE ON)

# Політики і помітні установки
set(CMAKE_C_STANDARD 11)

