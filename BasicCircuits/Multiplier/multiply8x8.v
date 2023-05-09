module hw1(Y,A,B);
  input [7:0]A;
  input [7:0]B;
  output [15:0]Y;
  wire [63:0]p;
  wire [41:0]s;
  wire [55:0]c;
  
  //AND operations for first bit
  and g1(p[0],B[0],A[0]);
  and g2(p[1],B[0],A[1]);
  and g3(p[2],B[0],A[2]);
  and g4(p[3],B[0],A[3]);
  and g5(p[4],B[0],A[4]);
  and g6(p[5],B[0],A[5]);
  and g7(p[6],B[0],A[6]);
  and g8(p[7],B[0],A[7]);
  
  //AND operations for second bit
  and g9(p[8],B[1],A[0]);
  and g10(p[9],B[1],A[1]);
  and g11(p[10],B[1],A[2]);
  and g12(p[11],B[1],A[3]);
  and g13(p[12],B[1],A[4]);
  and g14(p[13],B[1],A[5]);
  and g15(p[14],B[1],A[6]);
  and g16(p[15],B[1],A[7]);
  
  //AND operations for third bit
  and g17(p[16],B[2],A[0]);
  and g18(p[17],B[2],A[1]);
  and g19(p[18],B[2],A[2]);
  and g20(p[19],B[2],A[3]);
  and g21(p[20],B[2],A[4]);
  and g22(p[21],B[2],A[5]);
  and g23(p[22],B[2],A[6]);
  and g24(p[23],B[2],A[7]);
  
  //AND operations for fourth bit
  and g25(p[24],B[3],A[0]);
  and g26(p[25],B[3],A[1]);
  and g27(p[26],B[3],A[2]);
  and g28(p[27],B[3],A[3]);
  and g29(p[28],B[3],A[4]);
  and g30(p[29],B[3],A[5]);
  and g31(p[30],B[3],A[6]);
  and g32(p[31],B[3],A[7]);
  
  //AND operations for fifth bit
  and g33(p[32],B[4],A[0]);
  and g34(p[33],B[4],A[1]);
  and g35(p[34],B[4],A[2]);
  and g36(p[35],B[4],A[3]);
  and g37(p[36],B[4],A[4]);
  and g38(p[37],B[4],A[5]);
  and g39(p[38],B[4],A[6]);
  and g40(p[39],B[4],A[7]);
  
  //AND operations for sixth bit
  and g41(p[40],B[5],A[0]);
  and g42(p[41],B[5],A[1]);
  and g43(p[42],B[5],A[2]);
  and g44(p[43],B[5],A[3]);
  and g45(p[44],B[5],A[4]);
  and g46(p[45],B[5],A[5]);
  and g47(p[46],B[5],A[6]);
  and g48(p[47],B[5],A[7]);
  
  //AND operations for seventh bit
  and g49(p[48],B[6],A[0]);
  and g50(p[49],B[6],A[1]);
  and g51(p[50],B[6],A[2]);
  and g52(p[51],B[6],A[3]);
  and g53(p[52],B[6],A[4]);
  and g54(p[53],B[6],A[5]);
  and g55(p[54],B[6],A[6]);
  and g56(p[55],B[6],A[7]);
  
  //AND operations for eighth bit
  and g57(p[56],B[7],A[0]);
  and g58(p[57],B[7],A[1]);
  and g59(p[58],B[7],A[2]);
  and g60(p[59],B[7],A[3]);
  and g61(p[60],B[7],A[4]);
  and g62(p[61],B[7],A[5]);
  and g63(p[62],B[7],A[6]);
  and g64(p[63],B[7],A[7]);
  
  //Addition for the obtained results by shifting
  
  assign Y[0] = p[0];
  
  fa f1(Y[1],c[0],p[1],p[8],0);
  
  fa f2(s[0],c[1],c[0],p[2],p[9]);
  fa f3(Y[2],c[2],s[0],p[16],0);
  
  fa f4(s[1],c[3],c[1],c[2],p[3]);
  fa f5(s[2],c[4],s[1],p[10],p[17]);
  fa f6(Y[3],c[5],s[2],p[24],0);
  
  fa f7(s[3],c[6],c[5],c[4],c[3]);
  fa f8(s[4],c[7],s[3],p[4],p[11]);
  fa f9(s[5],c[8],s[4],p[18],p[25]);
  fa f10(Y[4],c[9],s[5],p[32],0);
  
  fa f11(s[6],c[10],c[6],c[7],c[8]);
  fa f12(s[7],c[11],c[9],s[6],p[5]);
  fa f13(s[8],c[12],s[7],p[12],p[19]);
  fa f14(s[9],c[13],s[8],p[26],p[33]);
  fa f15(Y[5],c[14],s[9],p[40],0);
  
  fa f16(s[10],c[15],c[10],c[11],c[12]);
  fa f17(s[11],c[16],s[10],c[13],c[14]);
  fa f18(s[12],c[17],s[11],p[6],p[13]);
  fa f19(s[13],c[18],s[12],p[20],p[27]);
  fa f20(s[14],c[19],s[13],p[34],p[41]);
  fa f21(Y[6],c[20],s[14],p[48],0);
  
  fa f22(s[15],c[21],c[15],c[16],c[17]);
  fa f23(s[16],c[22],s[15],c[18],c[19]);
  fa f24(s[17],c[23],s[16],c[20],p[7]);
  fa f25(s[18],c[24],s[17],p[14],p[21]);
  fa f26(s[19],c[25],s[18],p[28],p[35]);
  fa f27(s[20],c[26],s[19],p[42],p[49]);
  fa f28(Y[7],c[27],s[20],p[56],0);
  
  fa f29(s[21],c[28],c[21],c[22],c[23]);
  fa f30(s[22],c[29],s[21],c[24],c[25]);
  fa f31(s[23],c[30],s[22],c[26],c[27]);
  fa f32(s[24],c[31],s[23],p[15],p[22]);
  fa f33(s[25],c[32],s[24],p[29],p[36]);
  fa f34(s[26],c[33],s[25],p[43],p[50]);
  fa f35(Y[8],c[34],s[26],p[57],0);
  
  fa f36(s[27],c[35],c[28],c[29],c[30]);
  fa f37(s[28],c[36],s[27],c[31],c[32]);
  fa f38(s[29],c[37],s[28],c[33],c[34]);
  fa f39(s[30],c[38],s[29],p[23],p[30]);
  fa f40(s[31],c[39],s[30],p[37],p[44]);
  fa f41(Y[9],c[40],s[31],p[51],p[58]);
  
  fa f42(s[32],c[41],c[35],c[36],c[37]);
  fa f43(s[33],c[42],s[32],c[38],c[39]);
  fa f44(s[34],c[43],s[33],c[40],p[31]);
  fa f45(s[35],c[44],s[34],p[38],p[45]);
  fa f46(Y[10],c[45],s[35],p[52],p[59]);
  
  fa f47(s[36],c[46],c[41],c[42],c[43]);
  fa f48(s[37],c[47],s[36],c[44],c[45]);
  fa f49(s[38],c[48],s[37],p[39],p[46]);
  fa f50(Y[11],c[49],s[38],p[53],p[60]);
  
  fa f51(s[39],c[50],c[46],c[47],c[48]);
  fa f52(s[40],c[51],s[39],c[49],p[47]);
  fa f53(Y[12],c[52],s[40],p[54],p[61]);
  
  fa f54(s[41],c[53],c[50],c[51],c[52]);
  fa f55(Y[13],c[54],s[41],p[55],p[62]);
  
  fa f56(Y[14],c[55],c[53],c[54],p[63]);
  
  assign Y[15] = c[55];
  
endmodule