/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_ian_keypad_controller (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:6] = 0;
  assign uio_oe  = 8'b00111111;

  assign uo_out[7] = 0;
  wire reset = !rst_n;
  wire [3:0] key;

  // the keypad scanner
  keypad keypad (
    .clk(clk),
    .reset(reset),
    .rows(ui_in[3:0]), // input
    .cols(uio_out[3:0]), // output
    .counter_cols(uio_out[5:4]),
    .key(key)
  );
  
  // the digit decoder
  decoder decoder (
    .key(key),
    .segments(uo_out[6:0])
  );

endmodule
