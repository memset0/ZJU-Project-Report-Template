`timescale 1ns / 1ps

module MyMC14495 (
    input D0,
    input D1,
    input D2,
    input D3,
    input LE,
    input point,
    output reg p,
    output reg a,
    output reg b,
    output reg c,
    output reg d,
    output reg e,
    output reg f,
    output reg g
);

  always @* begin
    if (LE == 1'b0) begin
      // 使能端输入低电平，正常工作
      p = ~point;  // 小数点输出控制刚好与输入相反
      case ({
        D3, D2, D1, D0  // 将 D3~D0 直接组合成 4-bit 整数
      })
        4'b0000: {a, b, c, d, e, f, g} = 7'b0000001;  // 0
        4'b0001: {a, b, c, d, e, f, g} = 7'b1001111;  // 1
        4'b0010: {a, b, c, d, e, f, g} = 7'b0010010;  // 2
        4'b0011: {a, b, c, d, e, f, g} = 7'b0000110;  // 3
        4'b0100: {a, b, c, d, e, f, g} = 7'b1001100;  // 4
        4'b0101: {a, b, c, d, e, f, g} = 7'b0100100;  // 5
        4'b0110: {a, b, c, d, e, f, g} = 7'b0100000;  // 6
        4'b0111: {a, b, c, d, e, f, g} = 7'b0001111;  // 7
        4'b1000: {a, b, c, d, e, f, g} = 7'b0000000;  // 8 
        4'b1001: {a, b, c, d, e, f, g} = 7'b0000100;  // 9
        4'b1010: {a, b, c, d, e, f, g} = 7'b0001000;  // A
        4'b1011: {a, b, c, d, e, f, g} = 7'b1100000;  // B
        4'b1100: {a, b, c, d, e, f, g} = 7'b0110001;  // C
        4'b1101: {a, b, c, d, e, f, g} = 7'b1000010;  // D
        4'b1110: {a, b, c, d, e, f, g} = 7'b0110000;  // E
        4'b1111: {a, b, c, d, e, f, g} = 7'b0111000;  // F
      endcase

    end else begin
      // 使能端输入高电平，关闭所有数码管
      p = 1'b0;
      {a, b, c, d, e, f, g} = 7'b1111111;
    end
  end
endmodule
