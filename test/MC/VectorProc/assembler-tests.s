# This file auto-generated by make_tests.py. Do not edit.
# RUN: llvm-mc -arch=vectorproc -show-encoding %s | FileCheck %s
or s18, s14, s0  # CHECK: [0x4e,0x02,0x00,0xc0]
or v12, v15, s25  # CHECK: [0x8f,0x81,0x0c,0xc4]
or.mask v0, s23, v13, s12  # CHECK: [0x0d,0x5c,0x06,0xc8]
or.invmask v24, s10, v23, s2  # CHECK: [0x17,0x2b,0x01,0xcc]
or v27, v11, v27  # CHECK: [0x6b,0x83,0x0d,0xd0]
or.mask v16, s13, v20, v17  # CHECK: [0x14,0xb6,0x08,0xd4]
or.invmask v13, s22, v21, v4  # CHECK: [0xb5,0x59,0x02,0xd8]
or s13, s21, 78  # CHECK: [0xb5,0x39,0x01,0x00]
or v13, v21, 123  # CHECK: [0xb5,0xed,0x01,0x10]
or.mask v13, s22, v21, 31  # CHECK: [0xb5,0xd9,0x0f,0x20]
or.invmask v13, s22, v21, 83  # CHECK: [0xb5,0xd9,0x29,0x30]
or v13, s21, 84  # CHECK: [0xb5,0x51,0x01,0x40]
or.mask v13, s22, s21, 185  # CHECK: [0xb5,0xd9,0x5c,0x50]
or.invmask v13, s22, s21, 85  # CHECK: [0xb5,0xd9,0x2a,0x60]
and s18, s6, s24  # CHECK: [0x46,0x02,0x1c,0xc0]
and v21, v22, s7  # CHECK: [0xb6,0x82,0x13,0xc4]
and.mask v25, s4, v3, s26  # CHECK: [0x23,0x13,0x1d,0xc8]
and.invmask v1, s15, v14, s8  # CHECK: [0x2e,0x3c,0x14,0xcc]
and v24, v21, v5  # CHECK: [0x15,0x83,0x12,0xd0]
and.mask v26, s0, v21, v16  # CHECK: [0x55,0x03,0x18,0xd4]
and.invmask v15, s0, v13, v24  # CHECK: [0xed,0x01,0x1c,0xd8]
and s15, s13, 241  # CHECK: [0xed,0xc5,0x83,0x00]
and v15, v13, 166  # CHECK: [0xed,0x99,0x82,0x10]
and.mask v15, s0, v13, 59  # CHECK: [0xed,0x81,0x9d,0x20]
and.invmask v15, s0, v13, 83  # CHECK: [0xed,0x81,0xa9,0x30]
and v15, s13, 173  # CHECK: [0xed,0xb5,0x82,0x40]
and.mask v15, s0, s13, 20  # CHECK: [0xed,0x01,0x8a,0x50]
and.invmask v15, s0, s13, 27  # CHECK: [0xed,0x81,0x8d,0x60]
xor s20, s15, s26  # CHECK: [0x8f,0x02,0x3d,0xc0]
xor v16, v8, s2  # CHECK: [0x08,0x02,0x31,0xc4]
xor.mask v11, s14, v24, s9  # CHECK: [0x78,0xb9,0x34,0xc8]
xor.invmask v25, s14, v12, s17  # CHECK: [0x2c,0xbb,0x38,0xcc]
xor v1, v15, v2  # CHECK: [0x2f,0x00,0x31,0xd0]
xor.mask v15, s25, v16, v0  # CHECK: [0xf0,0x65,0x30,0xd4]
xor.invmask v25, s17, v9, v2  # CHECK: [0x29,0x47,0x31,0xd8]
xor s25, s9, 152  # CHECK: [0x29,0x63,0x82,0x01]
xor v25, v9, 18  # CHECK: [0x29,0x4b,0x80,0x11]
xor.mask v25, s17, v9, 163  # CHECK: [0x29,0xc7,0xd1,0x21]
xor.invmask v25, s17, v9, 165  # CHECK: [0x29,0xc7,0xd2,0x31]
xor v25, s9, 127  # CHECK: [0x29,0xff,0x81,0x41]
xor.mask v25, s17, s9, 6  # CHECK: [0x29,0x47,0x83,0x51]
xor.invmask v25, s17, s9, 205  # CHECK: [0x29,0xc7,0xe6,0x61]
add.i s11, s24, s11  # CHECK: [0x78,0x81,0x55,0xc0]
add.i v26, v9, s8  # CHECK: [0x49,0x03,0x54,0xc4]
add.i.mask v11, s16, v23, s23  # CHECK: [0x77,0xc1,0x5b,0xc8]
add.i.invmask v27, s22, v17, s14  # CHECK: [0x71,0x5b,0x57,0xcc]
add.i v27, v13, v23  # CHECK: [0x6d,0x83,0x5b,0xd0]
add.i.mask v19, s1, v15, v22  # CHECK: [0x6f,0x06,0x5b,0xd4]
add.i.invmask v8, s22, v10, v7  # CHECK: [0x0a,0xd9,0x53,0xd8]
add.i s8, s10, 45  # CHECK: [0x0a,0xb5,0x80,0x02]
add.i v8, v10, 245  # CHECK: [0x0a,0xd5,0x83,0x12]
add.i.mask v8, s22, v10, 126  # CHECK: [0x0a,0x59,0xbf,0x22]
add.i.invmask v8, s22, v10, 251  # CHECK: [0x0a,0xd9,0xfd,0x32]
add.i v8, s10, 130  # CHECK: [0x0a,0x09,0x82,0x42]
add.i.mask v8, s22, s10, 140  # CHECK: [0x0a,0x59,0xc6,0x52]
add.i.invmask v8, s22, s10, 79  # CHECK: [0x0a,0xd9,0xa7,0x62]
sub.i s8, s11, s25  # CHECK: [0x0b,0x81,0x6c,0xc0]
sub.i v15, v24, s12  # CHECK: [0xf8,0x01,0x66,0xc4]
sub.i.mask v12, s21, v24, s17  # CHECK: [0x98,0xd5,0x68,0xc8]
sub.i.invmask v27, s20, v11, s2  # CHECK: [0x6b,0x53,0x61,0xcc]
sub.i v0, v22, v14  # CHECK: [0x16,0x00,0x67,0xd0]
sub.i.mask v6, s18, v20, v14  # CHECK: [0xd4,0x48,0x67,0xd4]
sub.i.invmask v0, s3, v26, v14  # CHECK: [0x1a,0x0c,0x67,0xd8]
sub.i s0, s26, 116  # CHECK: [0x1a,0xd0,0x01,0x03]
sub.i v0, v26, 155  # CHECK: [0x1a,0x6c,0x02,0x13]
sub.i.mask v0, s3, v26, 6  # CHECK: [0x1a,0x0c,0x03,0x23]
sub.i.invmask v0, s3, v26, 39  # CHECK: [0x1a,0x8c,0x13,0x33]
sub.i v0, s26, 20  # CHECK: [0x1a,0x50,0x00,0x43]
sub.i.mask v0, s3, s26, 59  # CHECK: [0x1a,0x8c,0x1d,0x53]
sub.i.invmask v0, s3, s26, 186  # CHECK: [0x1a,0x0c,0x5d,0x63]
mul.i s7, s22, s17  # CHECK: [0xf6,0x80,0x78,0xc0]
mul.i v21, v0, s5  # CHECK: [0xa0,0x82,0x72,0xc4]
mul.i.mask v25, s14, v9, s6  # CHECK: [0x29,0x3b,0x73,0xc8]
mul.i.invmask v15, s5, v6, s10  # CHECK: [0xe6,0x15,0x75,0xcc]
mul.i v1, v2, v5  # CHECK: [0x22,0x80,0x72,0xd0]
mul.i.mask v1, s7, v8, v8  # CHECK: [0x28,0x1c,0x74,0xd4]
mul.i.invmask v3, s16, v7, v5  # CHECK: [0x67,0xc0,0x72,0xd8]
mul.i s3, s7, 109  # CHECK: [0x67,0xb4,0x81,0x03]
mul.i v3, v7, 74  # CHECK: [0x67,0x28,0x81,0x13]
mul.i.mask v3, s16, v7, 145  # CHECK: [0x67,0xc0,0xc8,0x23]
mul.i.invmask v3, s16, v7, 176  # CHECK: [0x67,0x40,0xd8,0x33]
mul.i v3, s7, 64  # CHECK: [0x67,0x00,0x81,0x43]
mul.i.mask v3, s16, s7, 172  # CHECK: [0x67,0x40,0xd6,0x53]
mul.i.invmask v3, s16, s7, 136  # CHECK: [0x67,0x40,0xc4,0x63]
ashr s5, s18, s3  # CHECK: [0xb2,0x80,0x91,0xc0]
ashr v22, v15, s4  # CHECK: [0xcf,0x02,0x92,0xc4]
ashr.mask v11, s1, v14, s2  # CHECK: [0x6e,0x05,0x91,0xc8]
ashr.invmask v18, s7, v26, s3  # CHECK: [0x5a,0x9e,0x91,0xcc]
ashr v1, v21, v4  # CHECK: [0x35,0x00,0x92,0xd0]
ashr.mask v8, s20, v2, v5  # CHECK: [0x02,0xd1,0x92,0xd4]
ashr.invmask v13, s2, v0, v7  # CHECK: [0xa0,0x89,0x93,0xd8]
ashr s13, s0, 27  # CHECK: [0xa0,0x6d,0x80,0x04]
ashr v13, v0, 40  # CHECK: [0xa0,0xa1,0x80,0x14]
ashr.mask v13, s2, v0, 179  # CHECK: [0xa0,0x89,0xd9,0x24]
ashr.invmask v13, s2, v0, 221  # CHECK: [0xa0,0x89,0xee,0x34]
ashr v13, s0, 57  # CHECK: [0xa0,0xe5,0x80,0x44]
ashr.mask v13, s2, s0, 17  # CHECK: [0xa0,0x89,0x88,0x54]
ashr.invmask v13, s2, s0, 128  # CHECK: [0xa0,0x09,0xc0,0x64]
shr s13, s5, s11  # CHECK: [0xa5,0x81,0xa5,0xc0]
shr v2, v22, s23  # CHECK: [0x56,0x80,0xab,0xc4]
shr.mask v11, s24, v15, s17  # CHECK: [0x6f,0xe1,0xa8,0xc8]
shr.invmask v13, s26, v3, s3  # CHECK: [0xa3,0xe9,0xa1,0xcc]
shr v23, v23, v15  # CHECK: [0xf7,0x82,0xa7,0xd0]
shr.mask v13, s14, v22, v14  # CHECK: [0xb6,0x39,0xa7,0xd4]
shr.invmask v20, s12, v13, v11  # CHECK: [0x8d,0xb2,0xa5,0xd8]
shr s20, s13, 164  # CHECK: [0x8d,0x92,0x02,0x05]
shr v20, v13, 22  # CHECK: [0x8d,0x5a,0x00,0x15]
shr.mask v20, s12, v13, 253  # CHECK: [0x8d,0xb2,0x7e,0x25]
shr.invmask v20, s12, v13, 40  # CHECK: [0x8d,0x32,0x14,0x35]
shr v20, s13, 43  # CHECK: [0x8d,0xae,0x00,0x45]
shr.mask v20, s12, s13, 38  # CHECK: [0x8d,0x32,0x13,0x55]
shr.invmask v20, s12, s13, 197  # CHECK: [0x8d,0xb2,0x62,0x65]
shl s8, s3, s11  # CHECK: [0x03,0x81,0xb5,0xc0]
shl v17, v3, s2  # CHECK: [0x23,0x02,0xb1,0xc4]
shl.mask v2, s5, v17, s5  # CHECK: [0x51,0x94,0xb2,0xc8]
shl.invmask v25, s23, v1, s8  # CHECK: [0x21,0x5f,0xb4,0xcc]
shl v15, v1, v24  # CHECK: [0xe1,0x01,0xbc,0xd0]
shl.mask v17, s27, v11, v17  # CHECK: [0x2b,0xee,0xb8,0xd4]
shl.invmask v1, s5, v20, v2  # CHECK: [0x34,0x14,0xb1,0xd8]
shl s1, s20, 28  # CHECK: [0x34,0x70,0x80,0x05]
shl v1, v20, 166  # CHECK: [0x34,0x98,0x82,0x15]
shl.mask v1, s5, v20, 204  # CHECK: [0x34,0x14,0xe6,0x25]
shl.invmask v1, s5, v20, 43  # CHECK: [0x34,0x94,0x95,0x35]
shl v1, s20, 166  # CHECK: [0x34,0x98,0x82,0x45]
shl.mask v1, s5, s20, 136  # CHECK: [0x34,0x14,0xc4,0x55]
shl.invmask v1, s5, s20, 38  # CHECK: [0x34,0x14,0x93,0x65]
add.f s19, s20, s12  # CHECK: [0x74,0x02,0x06,0xc2]
add.f v13, v15, s14  # CHECK: [0xaf,0x01,0x07,0xc6]
add.f.mask v4, s8, v21, s11  # CHECK: [0x95,0xa0,0x05,0xca]
add.f.invmask v16, s25, v4, s18  # CHECK: [0x04,0x66,0x09,0xce]
add.f v25, v23, v10  # CHECK: [0x37,0x03,0x05,0xd2]
add.f.mask v18, s13, v19, v17  # CHECK: [0x53,0xb6,0x08,0xd6]
add.f.invmask v27, s21, v20, v1  # CHECK: [0x74,0xd7,0x00,0xda]
sub.f s1, s7, s2  # CHECK: [0x27,0x00,0x11,0xc2]
sub.f v2, v0, s4  # CHECK: [0x40,0x00,0x12,0xc6]
sub.f.mask v11, s22, v27, s27  # CHECK: [0x7b,0xd9,0x1d,0xca]
sub.f.invmask v6, s0, v0, s7  # CHECK: [0xc0,0x80,0x13,0xce]
sub.f v12, v7, v24  # CHECK: [0x87,0x01,0x1c,0xd2]
sub.f.mask v22, s18, v4, v10  # CHECK: [0xc4,0x4a,0x15,0xd6]
sub.f.invmask v2, s11, v14, v5  # CHECK: [0x4e,0xac,0x12,0xda]
mul.f s25, s20, s25  # CHECK: [0x34,0x83,0x2c,0xc2]
mul.f v15, v0, s3  # CHECK: [0xe0,0x81,0x21,0xc6]
mul.f.mask v9, s6, v9, s12  # CHECK: [0x29,0x19,0x26,0xca]
mul.f.invmask v16, s21, v5, s4  # CHECK: [0x05,0x56,0x22,0xce]
mul.f v13, v21, v24  # CHECK: [0xb5,0x01,0x2c,0xd2]
mul.f.mask v1, s20, v12, v19  # CHECK: [0x2c,0xd0,0x29,0xd6]
mul.f.invmask v27, s26, v3, v25  # CHECK: [0x63,0xeb,0x2c,0xda]
clz s14, s1  # CHECK: [0xc0,0x81,0xc0,0xc0]
clz v16, s19  # CHECK: [0x00,0x82,0xc9,0xc4]
clz.mask v17, s20, s18  # CHECK: [0x20,0x52,0xc9,0xc8]
clz.invmask v11, s24, s19  # CHECK: [0x60,0xe1,0xc9,0xcc]
clz v3, v19  # CHECK: [0x60,0x80,0xc9,0xd0]
clz.mask v15, s0, v21  # CHECK: [0xe0,0x81,0xca,0xd4]
clz.invmask v23, s14, v17  # CHECK: [0xe0,0xba,0xc8,0xd8]
ctz s5, s15  # CHECK: [0xa0,0x80,0xe7,0xc0]
ctz v27, s23  # CHECK: [0x60,0x83,0xeb,0xc4]
ctz.mask v8, s25, s5  # CHECK: [0x00,0xe5,0xe2,0xc8]
ctz.invmask v4, s24, s12  # CHECK: [0x80,0x60,0xe6,0xcc]
ctz v27, v16  # CHECK: [0x60,0x03,0xe8,0xd0]
ctz.mask v10, s10, v24  # CHECK: [0x40,0x29,0xec,0xd4]
ctz.invmask v18, s19, v16  # CHECK: [0x40,0x4e,0xe8,0xd8]
move s26, s9  # CHECK: [0x40,0x83,0xf4,0xc0]
move v26, s26  # CHECK: [0x40,0x03,0xfd,0xc4]
move.mask v10, s9, s18  # CHECK: [0x40,0x25,0xf9,0xc8]
move.invmask v7, s6, s3  # CHECK: [0xe0,0x98,0xf1,0xcc]
move v16, v15  # CHECK: [0x00,0x82,0xf7,0xd0]
move.mask v13, s2, v14  # CHECK: [0xa0,0x09,0xf7,0xd4]
move.invmask v12, s7, v17  # CHECK: [0x80,0x9d,0xf8,0xd8]
reciprocal s7, s9  # CHECK: [0xe0,0x80,0xc4,0xc1]
shuffle v1, v2, v3  # CHECK: [0x22,0x80,0xd1,0xd0]
getfield s4, v5, s6  # CHECK: [0x85,0x00,0xa3,0xc5]
setgt.i s12, s17, s25  # CHECK: [0x91,0x81,0x2c,0xc1]
setgt.i s12, v17, s25  # CHECK: [0x91,0x81,0x2c,0xc5]
setgt.i s12, v17, v25  # CHECK: [0x91,0x81,0x2c,0xd1]
setgt.i s12, s17, 118  # CHECK: [0x91,0xd9,0x01,0x09]
setgt.i s12, v17, 199  # CHECK: [0x91,0x1d,0x03,0x19]
setge.i s12, s17, s25  # CHECK: [0x91,0x81,0x3c,0xc1]
setge.i s12, v17, s25  # CHECK: [0x91,0x81,0x3c,0xc5]
setge.i s12, v17, v25  # CHECK: [0x91,0x81,0x3c,0xd1]
setge.i s12, s17, 82  # CHECK: [0x91,0x49,0x81,0x09]
setge.i s12, v17, 165  # CHECK: [0x91,0x95,0x82,0x19]
setlt.i s12, s17, s25  # CHECK: [0x91,0x81,0x4c,0xc1]
setlt.i s12, v17, s25  # CHECK: [0x91,0x81,0x4c,0xc5]
setlt.i s12, v17, v25  # CHECK: [0x91,0x81,0x4c,0xd1]
setlt.i s12, s17, 99  # CHECK: [0x91,0x8d,0x01,0x0a]
setlt.i s12, v17, 17  # CHECK: [0x91,0x45,0x00,0x1a]
setle.i s12, s17, s25  # CHECK: [0x91,0x81,0x5c,0xc1]
setle.i s12, v17, s25  # CHECK: [0x91,0x81,0x5c,0xc5]
setle.i s12, v17, v25  # CHECK: [0x91,0x81,0x5c,0xd1]
setle.i s12, s17, 29  # CHECK: [0x91,0x75,0x80,0x0a]
setle.i s12, v17, 116  # CHECK: [0x91,0xd1,0x81,0x1a]
setgt.u s12, s17, s25  # CHECK: [0x91,0x81,0x6c,0xc1]
setgt.u s12, v17, s25  # CHECK: [0x91,0x81,0x6c,0xc5]
setgt.u s12, v17, v25  # CHECK: [0x91,0x81,0x6c,0xd1]
setgt.u s12, s17, 119  # CHECK: [0x91,0xdd,0x01,0x0b]
setgt.u s12, v17, 47  # CHECK: [0x91,0xbd,0x00,0x1b]
setge.u s12, s17, s25  # CHECK: [0x91,0x81,0x7c,0xc1]
setge.u s12, v17, s25  # CHECK: [0x91,0x81,0x7c,0xc5]
setge.u s12, v17, v25  # CHECK: [0x91,0x81,0x7c,0xd1]
setge.u s12, s17, 149  # CHECK: [0x91,0x55,0x82,0x0b]
setge.u s12, v17, 67  # CHECK: [0x91,0x0d,0x81,0x1b]
setlt.u s12, s17, s25  # CHECK: [0x91,0x81,0x8c,0xc1]
setlt.u s12, v17, s25  # CHECK: [0x91,0x81,0x8c,0xc5]
setlt.u s12, v17, v25  # CHECK: [0x91,0x81,0x8c,0xd1]
setlt.u s12, s17, 4  # CHECK: [0x91,0x11,0x00,0x0c]
setlt.u s12, v17, 160  # CHECK: [0x91,0x81,0x02,0x1c]
setle.u s12, s17, s25  # CHECK: [0x91,0x81,0x9c,0xc1]
setle.u s12, v17, s25  # CHECK: [0x91,0x81,0x9c,0xc5]
setle.u s12, v17, v25  # CHECK: [0x91,0x81,0x9c,0xd1]
setle.u s12, s17, 114  # CHECK: [0x91,0xc9,0x81,0x0c]
setle.u s12, v17, 8  # CHECK: [0x91,0x21,0x80,0x1c]
setgt.f s12, s17, s25  # CHECK: [0x91,0x81,0xcc,0xc2]
setgt.f s12, v17, s25  # CHECK: [0x91,0x81,0xcc,0xc6]
setgt.f s12, v17, v25  # CHECK: [0x91,0x81,0xcc,0xd2]
setge.f s12, s17, s25  # CHECK: [0x91,0x81,0xdc,0xc2]
setge.f s12, v17, s25  # CHECK: [0x91,0x81,0xdc,0xc6]
setge.f s12, v17, v25  # CHECK: [0x91,0x81,0xdc,0xd2]
setlt.f s12, s17, s25  # CHECK: [0x91,0x81,0xec,0xc2]
setlt.f s12, v17, s25  # CHECK: [0x91,0x81,0xec,0xc6]
setlt.f s12, v17, v25  # CHECK: [0x91,0x81,0xec,0xd2]
setle.f s12, s17, s25  # CHECK: [0x91,0x81,0xfc,0xc2]
setle.f s12, v17, s25  # CHECK: [0x91,0x81,0xfc,0xc6]
setle.f s12, v17, v25  # CHECK: [0x91,0x81,0xfc,0xd2]
getfield s1, v2, s3   # CHECK: [0x22,0x80,0xa1,0xc5]
load.u8 s10, 20(s5)  # CHECK: [0x45,0x51,0x00,0xa0]
load.u8 s11, (s6)  # CHECK: [0x66,0x01,0x00,0xa0]
load.s8 s10, 20(s5)  # CHECK: [0x45,0x51,0x00,0xa2]
load.s8 s11, (s6)  # CHECK: [0x66,0x01,0x00,0xa2]
load.u16 s12, 30(s7)  # CHECK: [0x87,0x79,0x00,0xa4]
load.u16 s13, (s8)  # CHECK: [0xa8,0x01,0x00,0xa4]
load.s16 s12, 30(s7)  # CHECK: [0x87,0x79,0x00,0xa6]
load.s16 s13, (s8)  # CHECK: [0xa8,0x01,0x00,0xa6]
load.32 s14, 40(s9)  # CHECK: [0xc9,0xa1,0x00,0xa8]
load.32 s15, (s10)  # CHECK: [0xea,0x01,0x00,0xa8]
store.8 s1, 50(s2)  # CHECK: [0x22,0xc8,0x00,0x82]
store.16 s3, 60(s4)  # CHECK: [0x64,0xf0,0x00,0x86]
store.32 s5, 70(s6)  # CHECK: [0xa6,0x18,0x01,0x88]
load.v v2, 20(s5)  # CHECK: [0x45,0x50,0x00,0xae]
load.v v3, (s6)  # CHECK: [0x66,0x00,0x00,0xae]
store.v v2, 20(s5)  # CHECK: [0x45,0x50,0x00,0x8e]
store.v v3, (s6)  # CHECK: [0x66,0x00,0x00,0x8e]
load.v.mask v2, s7, 20(s5)  # CHECK: [0x45,0x1c,0x0a,0xb0]
load.v.mask v3, s7, (s6)  # CHECK: [0x66,0x1c,0x00,0xb0]
store.v.mask v2, s7, 20(s5)  # CHECK: [0x45,0x1c,0x0a,0x90]
store.v.mask v3, s7, (s6)  # CHECK: [0x66,0x1c,0x00,0x90]
store.scat v2, (v5)  # CHECK: [0x45,0x00,0x00,0x9a]
store.scat.mask v3, s7, (v6)  # CHECK: [0x66,0x1c,0x00,0x9c]
load.sync s2, 20(s5)  # CHECK: [0x45,0x50,0x00,0xaa]
load.sync s3, (s6)  # CHECK: [0x66,0x00,0x00,0xaa]
store.sync s2, 20(s5)  # CHECK: [0x45,0x50,0x00,0x8a]
store.sync s3, (s6)  # CHECK: [0x66,0x00,0x00,0x8a]
getcr s7, 9  # CHECK: [0xe9,0x00,0x00,0xac]
setcr s11, 13  # CHECK: [0x6d,0x01,0x00,0x8c]