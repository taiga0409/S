message("-----------test-----------")
# fileコマンドで指定されたGLOBパターンにマッチするファイル().cppの拡張子を持つ)を探し，SRCSに相対パスを保存
# CMAKE_CURRENT_SOURCE_DIRはCMakeLists.txtが存在するパスを取得
file(GLOB SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)
# test配下のcppファイル
message("SRCS = ${SRCS}")

foreach(file ${SRCS})
    # 実行ファイルの名前
    string(REPLACE "test/" "" name ${file})
    string(REPLACE ".cpp" "" name ${name})
    file(RELATIVE_PATH name ${CMAKE_CURRENT_SOURCE_DIR}/${dir} ${CMAKE_CURRENT_SOURCE_DIR}/${name})
    add_executable(${name} ${file})
    target_link_libraries(${name}
      ROBOT_NAME
    )
    target_compile_options(${name} PRIVATE -O3 -g -Wall -Wextra -Wno-long-long -pedantic)
endforeach(file ${SRCS})
