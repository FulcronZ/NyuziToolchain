# This file auto-generated by make_tests.py. Do not edit.
# RUN: llvm-mc -arch=vectorproc -disassemble %s | FileCheck %s
0xd5 0x02 0x0b 0xc0  # CHECK: or s22, s21, s22
0xd5 0x02 0x0b 0xc4  # CHECK: or v22, v21, s22
0xd5 0x52 0x0b 0xc8  # CHECK: or_mask v22, s20, v21, s22
0xd5 0x52 0x0b 0xcc  # CHECK: or_invmask v22, s20, v21, s22
0xd5 0x02 0x0b 0xd0  # CHECK: or v22, v21, v22
0xd5 0x52 0x0b 0xd4  # CHECK: or_mask v22, s20, v21, v22
0xd5 0x52 0x0b 0xd8  # CHECK: or_invmask v22, s20, v21, v22
0xd5 0x32 0x00 0x00  # CHECK: or s22, s21, 12
0xd5 0x32 0x00 0x10  # CHECK: or v22, v21, 12
0xd5 0x52 0x06 0x20  # CHECK: or_mask v22, s20, v21, 12
0xd5 0x52 0x06 0x30  # CHECK: or_invmask v22, s20, v21, 12
0xd5 0x32 0x00 0x40  # CHECK: or v22, s21, 12
0xd5 0x52 0x06 0x50  # CHECK: or_mask v22, s20, s21, 12
0xd5 0x52 0x06 0x60  # CHECK: or_invmask v22, s20, s21, 12
0x47 0x01 0x16 0xc0  # CHECK: and s10, s7, s12
0x47 0x01 0x16 0xc4  # CHECK: and v10, v7, s12
0x47 0x31 0x16 0xc8  # CHECK: and_mask v10, s12, v7, s12
0x47 0x31 0x16 0xcc  # CHECK: and_invmask v10, s12, v7, s12
0x47 0x01 0x16 0xd0  # CHECK: and v10, v7, v12
0x47 0x31 0x16 0xd4  # CHECK: and_mask v10, s12, v7, v12
0x47 0x31 0x16 0xd8  # CHECK: and_invmask v10, s12, v7, v12
0x47 0x79 0x82 0x00  # CHECK: and s10, s7, 158
0x47 0x79 0x82 0x10  # CHECK: and v10, v7, 158
0x47 0x31 0xcf 0x20  # CHECK: and_mask v10, s12, v7, 158
0x47 0x31 0xcf 0x30  # CHECK: and_invmask v10, s12, v7, 158
0x47 0x79 0x82 0x40  # CHECK: and v10, s7, 158
0x47 0x31 0xcf 0x50  # CHECK: and_mask v10, s12, s7, 158
0x47 0x31 0xcf 0x60  # CHECK: and_invmask v10, s12, s7, 158
0xd7 0x80 0x36 0xc0  # CHECK: xor s6, s23, s13
0xd7 0x80 0x36 0xc4  # CHECK: xor v6, v23, s13
0xd7 0x80 0x36 0xc8  # CHECK: xor_mask v6, s0, v23, s13
0xd7 0x80 0x36 0xcc  # CHECK: xor_invmask v6, s0, v23, s13
0xd7 0x80 0x36 0xd0  # CHECK: xor v6, v23, v13
0xd7 0x80 0x36 0xd4  # CHECK: xor_mask v6, s0, v23, v13
0xd7 0x80 0x36 0xd8  # CHECK: xor_invmask v6, s0, v23, v13
0xd7 0x98 0x80 0x01  # CHECK: xor s6, s23, 38
0xd7 0x98 0x80 0x11  # CHECK: xor v6, v23, 38
0xd7 0x00 0x93 0x21  # CHECK: xor_mask v6, s0, v23, 38
0xd7 0x00 0x93 0x31  # CHECK: xor_invmask v6, s0, v23, 38
0xd7 0x98 0x80 0x41  # CHECK: xor v6, s23, 38
0xd7 0x00 0x93 0x51  # CHECK: xor_mask v6, s0, s23, 38
0xd7 0x00 0x93 0x61  # CHECK: xor_invmask v6, s0, s23, 38
0x59 0x01 0x56 0xc0  # CHECK: add_i s10, s25, s12
0x59 0x01 0x56 0xc4  # CHECK: add_i v10, v25, s12
0x59 0x4d 0x56 0xc8  # CHECK: add_i_mask v10, s19, v25, s12
0x59 0x4d 0x56 0xcc  # CHECK: add_i_invmask v10, s19, v25, s12
0x59 0x01 0x56 0xd0  # CHECK: add_i v10, v25, v12
0x59 0x4d 0x56 0xd4  # CHECK: add_i_mask v10, s19, v25, v12
0x59 0x4d 0x56 0xd8  # CHECK: add_i_invmask v10, s19, v25, v12
0x59 0x11 0x81 0x02  # CHECK: add_i s10, s25, 68
0x59 0x11 0x81 0x12  # CHECK: add_i v10, v25, 68
0x59 0x4d 0xa2 0x22  # CHECK: add_i_mask v10, s19, v25, 68
0x59 0x4d 0xa2 0x32  # CHECK: add_i_invmask v10, s19, v25, 68
0x59 0x11 0x81 0x42  # CHECK: add_i v10, s25, 68
0x59 0x4d 0xa2 0x52  # CHECK: add_i_mask v10, s19, s25, 68
0x59 0x4d 0xa2 0x62  # CHECK: add_i_invmask v10, s19, s25, 68
0x3a 0x83 0x62 0xc0  # CHECK: sub_i s25, s26, s5
0x3a 0x83 0x62 0xc4  # CHECK: sub_i v25, v26, s5
0x3a 0xd7 0x62 0xc8  # CHECK: sub_i_mask v25, s21, v26, s5
0x3a 0xd7 0x62 0xcc  # CHECK: sub_i_invmask v25, s21, v26, s5
0x3a 0x83 0x62 0xd0  # CHECK: sub_i v25, v26, v5
0x3a 0xd7 0x62 0xd4  # CHECK: sub_i_mask v25, s21, v26, v5
0x3a 0xd7 0x62 0xd8  # CHECK: sub_i_invmask v25, s21, v26, v5
0x3a 0x0f 0x00 0x03  # CHECK: sub_i s25, s26, 3
0x3a 0x0f 0x00 0x13  # CHECK: sub_i v25, v26, 3
0x3a 0xd7 0x01 0x23  # CHECK: sub_i_mask v25, s21, v26, 3
0x3a 0xd7 0x01 0x33  # CHECK: sub_i_invmask v25, s21, v26, 3
0x3a 0x0f 0x00 0x43  # CHECK: sub_i v25, s26, 3
0x3a 0xd7 0x01 0x53  # CHECK: sub_i_mask v25, s21, s26, 3
0x3a 0xd7 0x01 0x63  # CHECK: sub_i_invmask v25, s21, s26, 3
0x6c 0x03 0x73 0xc0  # CHECK: mul_i s27, s12, s6
0x6c 0x03 0x73 0xc4  # CHECK: mul_i v27, v12, s6
0x6c 0x3b 0x73 0xc8  # CHECK: mul_i_mask v27, s14, v12, s6
0x6c 0x3b 0x73 0xcc  # CHECK: mul_i_invmask v27, s14, v12, s6
0x6c 0x03 0x73 0xd0  # CHECK: mul_i v27, v12, v6
0x6c 0x3b 0x73 0xd4  # CHECK: mul_i_mask v27, s14, v12, v6
0x6c 0x3b 0x73 0xd8  # CHECK: mul_i_invmask v27, s14, v12, v6
0x6c 0x77 0x81 0x03  # CHECK: mul_i s27, s12, 93
0x6c 0x77 0x81 0x13  # CHECK: mul_i v27, v12, 93
0x6c 0xbb 0xae 0x23  # CHECK: mul_i_mask v27, s14, v12, 93
0x6c 0xbb 0xae 0x33  # CHECK: mul_i_invmask v27, s14, v12, 93
0x6c 0x77 0x81 0x43  # CHECK: mul_i v27, s12, 93
0x6c 0xbb 0xae 0x53  # CHECK: mul_i_mask v27, s14, s12, 93
0x6c 0xbb 0xae 0x63  # CHECK: mul_i_invmask v27, s14, s12, 93
0x6f 0x02 0x96 0xc0  # CHECK: ashr s19, s15, s12
0x6f 0x02 0x96 0xc4  # CHECK: ashr v19, v15, s12
0x6f 0x4e 0x96 0xc8  # CHECK: ashr_mask v19, s19, v15, s12
0x6f 0x4e 0x96 0xcc  # CHECK: ashr_invmask v19, s19, v15, s12
0x6f 0x02 0x96 0xd0  # CHECK: ashr v19, v15, v12
0x6f 0x4e 0x96 0xd4  # CHECK: ashr_mask v19, s19, v15, v12
0x6f 0x4e 0x96 0xd8  # CHECK: ashr_invmask v19, s19, v15, v12
0x6f 0x66 0x83 0x04  # CHECK: ashr s19, s15, 217
0x6f 0x66 0x83 0x14  # CHECK: ashr v19, v15, 217
0x6f 0xce 0xec 0x24  # CHECK: ashr_mask v19, s19, v15, 217
0x6f 0xce 0xec 0x34  # CHECK: ashr_invmask v19, s19, v15, 217
0x6f 0x66 0x83 0x44  # CHECK: ashr v19, s15, 217
0x6f 0xce 0xec 0x54  # CHECK: ashr_mask v19, s19, s15, 217
0x6f 0xce 0xec 0x64  # CHECK: ashr_invmask v19, s19, s15, 217
0x57 0x80 0xac 0xc0  # CHECK: shr s2, s23, s25
0x57 0x80 0xac 0xc4  # CHECK: shr v2, v23, s25
0x57 0xc0 0xac 0xc8  # CHECK: shr_mask v2, s16, v23, s25
0x57 0xc0 0xac 0xcc  # CHECK: shr_invmask v2, s16, v23, s25
0x57 0x80 0xac 0xd0  # CHECK: shr v2, v23, v25
0x57 0xc0 0xac 0xd4  # CHECK: shr_mask v2, s16, v23, v25
0x57 0xc0 0xac 0xd8  # CHECK: shr_invmask v2, s16, v23, v25
0x57 0x98 0x03 0x05  # CHECK: shr s2, s23, 230
0x57 0x98 0x03 0x15  # CHECK: shr v2, v23, 230
0x57 0x40 0x73 0x25  # CHECK: shr_mask v2, s16, v23, 230
0x57 0x40 0x73 0x35  # CHECK: shr_invmask v2, s16, v23, 230
0x57 0x98 0x03 0x45  # CHECK: shr v2, s23, 230
0x57 0x40 0x73 0x55  # CHECK: shr_mask v2, s16, s23, 230
0x57 0x40 0x73 0x65  # CHECK: shr_invmask v2, s16, s23, 230
0x22 0x81 0xb9 0xc0  # CHECK: shl s9, s2, s19
0x22 0x81 0xb9 0xc4  # CHECK: shl v9, v2, s19
0x22 0xbd 0xb9 0xc8  # CHECK: shl_mask v9, s15, v2, s19
0x22 0xbd 0xb9 0xcc  # CHECK: shl_invmask v9, s15, v2, s19
0x22 0x81 0xb9 0xd0  # CHECK: shl v9, v2, v19
0x22 0xbd 0xb9 0xd4  # CHECK: shl_mask v9, s15, v2, v19
0x22 0xbd 0xb9 0xd8  # CHECK: shl_invmask v9, s15, v2, v19
0x22 0x91 0x81 0x05  # CHECK: shl s9, s2, 100
0x22 0x91 0x81 0x15  # CHECK: shl v9, v2, 100
0x22 0x3d 0xb2 0x25  # CHECK: shl_mask v9, s15, v2, 100
0x22 0x3d 0xb2 0x35  # CHECK: shl_invmask v9, s15, v2, 100
0x22 0x91 0x81 0x45  # CHECK: shl v9, s2, 100
0x22 0x3d 0xb2 0x55  # CHECK: shl_mask v9, s15, s2, 100
0x22 0x3d 0xb2 0x65  # CHECK: shl_invmask v9, s15, s2, 100
0x79 0x83 0x02 0xc2  # CHECK: add_f s27, s25, s5
0x79 0x83 0x02 0xc6  # CHECK: add_f v27, v25, s5
0x79 0xd7 0x02 0xca  # CHECK: add_f_mask v27, s21, v25, s5
0x79 0xd7 0x02 0xce  # CHECK: add_f_invmask v27, s21, v25, s5
0x79 0x83 0x02 0xd2  # CHECK: add_f v27, v25, v5
0x79 0xd7 0x02 0xd6  # CHECK: add_f_mask v27, s21, v25, v5
0x79 0xd7 0x02 0xda  # CHECK: add_f_invmask v27, s21, v25, v5
0x12 0x01 0x15 0xc2  # CHECK: sub_f s8, s18, s10
0x12 0x01 0x15 0xc6  # CHECK: sub_f v8, v18, s10
0x12 0x11 0x15 0xca  # CHECK: sub_f_mask v8, s4, v18, s10
0x12 0x11 0x15 0xce  # CHECK: sub_f_invmask v8, s4, v18, s10
0x12 0x01 0x15 0xd2  # CHECK: sub_f v8, v18, v10
0x12 0x11 0x15 0xd6  # CHECK: sub_f_mask v8, s4, v18, v10
0x12 0x11 0x15 0xda  # CHECK: sub_f_invmask v8, s4, v18, v10
0x88 0x82 0x26 0xc2  # CHECK: mul_f s20, s8, s13
0x88 0x82 0x26 0xc6  # CHECK: mul_f v20, v8, s13
0x88 0xee 0x26 0xca  # CHECK: mul_f_mask v20, s27, v8, s13
0x88 0xee 0x26 0xce  # CHECK: mul_f_invmask v20, s27, v8, s13
0x88 0x82 0x26 0xd2  # CHECK: mul_f v20, v8, v13
0x88 0xee 0x26 0xd6  # CHECK: mul_f_mask v20, s27, v8, v13
0x88 0xee 0x26 0xda  # CHECK: mul_f_invmask v20, s27, v8, v13
0x40 0x81 0xc4 0xc0  # CHECK: clz s10, s9
0x40 0x81 0xc4 0xc4  # CHECK: clz v10, s9
0x40 0xad 0xc4 0xc8  # CHECK: clz_mask v10, s11, s9
0x40 0xad 0xc4 0xcc  # CHECK: clz_invmask v10, s11, s9
0x40 0x81 0xc4 0xd0  # CHECK: clz v10, v9
0x40 0xad 0xc4 0xd4  # CHECK: clz_mask v10, s11, v9
0x40 0xad 0xc4 0xd8  # CHECK: clz_invmask v10, s11, v9
0x00 0x01 0xe5 0xc0  # CHECK: ctz s8, s10
0x00 0x01 0xe5 0xc4  # CHECK: ctz v8, s10
0x00 0x31 0xe5 0xc8  # CHECK: ctz_mask v8, s12, s10
0x00 0x31 0xe5 0xcc  # CHECK: ctz_invmask v8, s12, s10
0x00 0x01 0xe5 0xd0  # CHECK: ctz v8, v10
0x00 0x31 0xe5 0xd4  # CHECK: ctz_mask v8, s12, v10
0x00 0x31 0xe5 0xd8  # CHECK: ctz_invmask v8, s12, v10
0x40 0x82 0xfc 0xc0  # CHECK: move s18, s25
0x40 0x82 0xfc 0xc4  # CHECK: move v18, s25
0x40 0x96 0xfc 0xc8  # CHECK: move_mask v18, s5, s25
0x40 0x96 0xfc 0xcc  # CHECK: move_invmask v18, s5, s25
0x40 0x82 0xfc 0xd0  # CHECK: move v18, v25
0x40 0x96 0xfc 0xd4  # CHECK: move_mask v18, s5, v25
0x40 0x96 0xfc 0xd8  # CHECK: move_invmask v18, s5, v25
0x00 0x83 0xcb 0xc1  # CHECK: reciprocal s24, s23
0x00 0x83 0xcb 0xc5  # CHECK: reciprocal v24, s23
0x00 0xc7 0xcb 0xc9  # CHECK: reciprocal_mask v24, s17, s23
0x00 0xc7 0xcb 0xcd  # CHECK: reciprocal_invmask v24, s17, s23
0x00 0x83 0xcb 0xd1  # CHECK: reciprocal v24, v23
0x00 0xc7 0xcb 0xd5  # CHECK: reciprocal_mask v24, s17, v23
0x00 0xc7 0xcb 0xd9  # CHECK: reciprocal_invmask v24, s17, v23
0x22 0x80 0xd1 0xd0  # CHECK: shuffle v1, v2, v3
0x22 0x90 0xd1 0xd4  # CHECK: shuffle_mask v1, s4, v2, v3
0x22 0x90 0xd1 0xd8  # CHECK: shuffle_invmask v1, s4, v2, v3
0x85 0x00 0xa3 0xc5  # CHECK: getlane s4, v5, s6
0x85 0x1c 0x00 0x1d  # CHECK: getlane s4, v5, 7
0xe2 0x82 0x20 0xc1  # CHECK: setgt_i s23, s2, s1
0xe2 0x82 0x20 0xc5  # CHECK: setgt_i s23, v2, s1
0xe2 0x82 0x20 0xd1  # CHECK: setgt_i s23, v2, v1
0xe2 0x52 0x03 0x09  # CHECK: setgt_i s23, s2, 212
0xe2 0x52 0x03 0x19  # CHECK: setgt_i s23, v2, 212
0x20 0x00 0x3a 0xc1  # CHECK: setge_i s1, s0, s20
0x20 0x00 0x3a 0xc5  # CHECK: setge_i s1, v0, s20
0x20 0x00 0x3a 0xd1  # CHECK: setge_i s1, v0, v20
0x20 0x94 0x83 0x09  # CHECK: setge_i s1, s0, 229
0x20 0x94 0x83 0x19  # CHECK: setge_i s1, v0, 229
0x36 0x02 0x4b 0xc1  # CHECK: setlt_i s17, s22, s22
0x36 0x02 0x4b 0xc5  # CHECK: setlt_i s17, v22, s22
0x36 0x02 0x4b 0xd1  # CHECK: setlt_i s17, v22, v22
0x36 0x76 0x02 0x0a  # CHECK: setlt_i s17, s22, 157
0x36 0x76 0x02 0x1a  # CHECK: setlt_i s17, v22, 157
0xc6 0x82 0x51 0xc1  # CHECK: setle_i s22, s6, s3
0xc6 0x82 0x51 0xc5  # CHECK: setle_i s22, v6, s3
0xc6 0x82 0x51 0xd1  # CHECK: setle_i s22, v6, v3
0xc6 0xde 0x83 0x0a  # CHECK: setle_i s22, s6, 247
0xc6 0xde 0x83 0x1a  # CHECK: setle_i s22, v6, 247
0xfb 0x01 0x68 0xc1  # CHECK: setgt_u s15, s27, s16
0xfb 0x01 0x68 0xc5  # CHECK: setgt_u s15, v27, s16
0xfb 0x01 0x68 0xd1  # CHECK: setgt_u s15, v27, v16
0xfb 0xf1 0x00 0x0b  # CHECK: setgt_u s15, s27, 60
0xfb 0xf1 0x00 0x1b  # CHECK: setgt_u s15, v27, 60
0xb3 0x81 0x72 0xc1  # CHECK: setge_u s13, s19, s5
0xb3 0x81 0x72 0xc5  # CHECK: setge_u s13, v19, s5
0xb3 0x81 0x72 0xd1  # CHECK: setge_u s13, v19, v5
0xb3 0xa5 0x81 0x0b  # CHECK: setge_u s13, s19, 105
0xb3 0xa5 0x81 0x1b  # CHECK: setge_u s13, v19, 105
0x71 0x83 0x8a 0xc1  # CHECK: setlt_u s27, s17, s21
0x71 0x83 0x8a 0xc5  # CHECK: setlt_u s27, v17, s21
0x71 0x83 0x8a 0xd1  # CHECK: setlt_u s27, v17, v21
0x71 0xcb 0x02 0x0c  # CHECK: setlt_u s27, s17, 178
0x71 0xcb 0x02 0x1c  # CHECK: setlt_u s27, v17, 178
0x16 0x00 0x9b 0xc1  # CHECK: setle_u s0, s22, s22
0x16 0x00 0x9b 0xc5  # CHECK: setle_u s0, v22, s22
0x16 0x00 0x9b 0xd1  # CHECK: setle_u s0, v22, v22
0x16 0x44 0x83 0x0c  # CHECK: setle_u s0, s22, 209
0x16 0x44 0x83 0x1c  # CHECK: setle_u s0, v22, 209
0xa2 0x00 0xc0 0xc2  # CHECK: setgt_f s5, s2, s0
0xa2 0x00 0xc0 0xc6  # CHECK: setgt_f s5, v2, s0
0xa2 0x00 0xc0 0xd2  # CHECK: setgt_f s5, v2, v0
0xa6 0x80 0xd9 0xc2  # CHECK: setge_f s5, s6, s19
0xa6 0x80 0xd9 0xc6  # CHECK: setge_f s5, v6, s19
0xa6 0x80 0xd9 0xd2  # CHECK: setge_f s5, v6, v19
0x3b 0x02 0xec 0xc2  # CHECK: setlt_f s17, s27, s24
0x3b 0x02 0xec 0xc6  # CHECK: setlt_f s17, v27, s24
0x3b 0x02 0xec 0xd2  # CHECK: setlt_f s17, v27, v24
0xe6 0x01 0xf0 0xc2  # CHECK: setle_f s15, s6, s0
0xe6 0x01 0xf0 0xc6  # CHECK: setle_f s15, v6, s0
0xe6 0x01 0xf0 0xd2  # CHECK: setle_f s15, v6, v0
0x10 0x03 0x00 0xa0  # CHECK: load_u8 s24, (s16)
0x10 0x9f 0x02 0xa0  # CHECK: load_u8 s24, 167(s16)
0x45 0x00 0x00 0xa2  # CHECK: load_s8 s2, (s5)
0x45 0x58 0x03 0xa2  # CHECK: load_s8 s2, 214(s5)
0x07 0x01 0x00 0xa4  # CHECK: load_u16 s8, (s7)
0x07 0x19 0x00 0xa4  # CHECK: load_u16 s8, 6(s7)
0x6a 0x03 0x00 0xa6  # CHECK: load_s16 s27, (s10)
0x6a 0x8b 0x03 0xa6  # CHECK: load_s16 s27, 226(s10)
0xfa 0x02 0x00 0xa8  # CHECK: load_32 s23, (s26)
0xfa 0xf6 0x03 0xa8  # CHECK: load_32 s23, 253(s26)
0xb8 0x01 0x00 0xaa  # CHECK: load_sync s13, (s24)
0xb8 0x75 0x00 0xaa  # CHECK: load_sync s13, 29(s24)
0xd4 0x02 0x00 0x82  # CHECK: store_8 s22, (s20)
0xd4 0x22 0x00 0x82  # CHECK: store_8 s22, 8(s20)
0x9b 0x02 0x00 0x86  # CHECK: store_16 s20, (s27)
0x9b 0x3a 0x03 0x86  # CHECK: store_16 s20, 206(s27)
0x43 0x03 0x00 0x88  # CHECK: store_32 s26, (s3)
0x43 0x43 0x03 0x88  # CHECK: store_32 s26, 208(s3)
0x48 0x03 0x00 0x8a  # CHECK: store_sync s26, (s8)
0x48 0xff 0x01 0x8a  # CHECK: store_sync s26, 127(s8)
0x34 0xf0 0x01 0xae  # CHECK: load_v v1, 124(s20)
0x34 0x18 0x3e 0xb0  # CHECK: load_v_mask v1, s6, 124(s20)
0x34 0x18 0x3e 0xb2  # CHECK: load_v_invmask v1, s6, 124(s20)
0x34 0x00 0x00 0xae  # CHECK: load_v v1, (s20)
0x34 0x18 0x00 0xb0  # CHECK: load_v_mask v1, s6, (s20)
0x34 0x18 0x00 0xb2  # CHECK: load_v_invmask v1, s6, (s20)
0x34 0xf0 0x01 0x8e  # CHECK: store_v v1, 124(s20)
0x34 0x18 0x3e 0x90  # CHECK: store_v_mask v1, s6, 124(s20)
0x34 0x18 0x3e 0x92  # CHECK: store_v_invmask v1, s6, 124(s20)
0x34 0x00 0x00 0x8e  # CHECK: store_v v1, (s20)
0x34 0x18 0x00 0x90  # CHECK: store_v_mask v1, s6, (s20)
0x34 0x18 0x00 0x92  # CHECK: store_v_invmask v1, s6, (s20)
0x07 0xf2 0x03 0xba  # CHECK: load_gath v16, 252(v7)
0x07 0x5e 0x7e 0xbc  # CHECK: load_gath_mask v16, s23, 252(v7)
0x07 0x5e 0x7e 0xbe  # CHECK: load_gath_invmask v16, s23, 252(v7)
0x07 0x02 0x00 0xba  # CHECK: load_gath v16, (v7)
0x07 0x5e 0x00 0xbc  # CHECK: load_gath_mask v16, s23, (v7)
0x07 0x5e 0x00 0xbe  # CHECK: load_gath_invmask v16, s23, (v7)
0x07 0xf2 0x03 0x9a  # CHECK: store_scat v16, 252(v7)
0x07 0x5e 0x7e 0x9c  # CHECK: store_scat_mask v16, s23, 252(v7)
0x07 0x5e 0x7e 0x9e  # CHECK: store_scat_invmask v16, s23, 252(v7)
0x07 0x02 0x00 0x9a  # CHECK: store_scat v16, (v7)
0x07 0x5e 0x00 0x9c  # CHECK: store_scat_mask v16, s23, (v7)
0x07 0x5e 0x00 0x9e  # CHECK: store_scat_invmask v16, s23, (v7)
0x98 0xf2 0x01 0xb4  # CHECK: load_strd v20, 124(s24)
0x98 0x5a 0x3e 0xb6  # CHECK: load_strd_mask v20, s22, 124(s24)
0x98 0x5a 0x3e 0xb8  # CHECK: load_strd_invmask v20, s22, 124(s24)
0x98 0x02 0x00 0xb4  # CHECK: load_strd v20, (s24)
0x98 0x5a 0x00 0xb6  # CHECK: load_strd_mask v20, s22, (s24)
0x98 0x5a 0x00 0xb8  # CHECK: load_strd_invmask v20, s22, (s24)
0x98 0xf2 0x01 0x94  # CHECK: store_strd v20, 124(s24)
0x98 0x5a 0x3e 0x96  # CHECK: store_strd_mask v20, s22, 124(s24)
0x98 0x5a 0x3e 0x98  # CHECK: store_strd_invmask v20, s22, 124(s24)
0x98 0x02 0x00 0x94  # CHECK: store_strd v20, (s24)
0x98 0x5a 0x00 0x96  # CHECK: store_strd_mask v20, s22, (s24)
0x98 0x5a 0x00 0x98  # CHECK: store_strd_invmask v20, s22, (s24)
0xe9 0x00 0x00 0xac  # CHECK: getcr s7, 9
0x6d 0x01 0x00 0x8c  # CHECK: setcr s11, 13
0x07 0x00 0x00 0xe4  # CHECK: dflush s7
0x00 0x00 0x00 0xe8  # CHECK: membar
0x09 0x00 0x00 0xe2  # CHECK: dinvalidate s9
0x0b 0x00 0x00 0xe6  # CHECK: iinvalidate s11
