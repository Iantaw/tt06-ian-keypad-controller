`default_nettype none
`timescale 1ns/1ns

module keypad(
    input wire clk,
    input wire reset,
    input [3:0] rows, // inputs
    output reg [3:0] cols, // outputs
    output reg [1:0] counter_cols,
    output reg led_a,
    output reg led_b,
    output reg led_c,
    output reg led_d
);

// Debounced Rows

// Instantiate the debounce module for each row
wire [3:0] debounced_rows; // Debounced signals for each row

debounce #(.HIST_LEN(8)) debounce_row0 (
    .clk(clk),
    .reset(reset),
    .button(rows[0]),
    .debounced(debounced_rows[0])
);

debounce #(.HIST_LEN(8)) debounce_row1 (
    .clk(clk),
    .reset(reset),
    .button(rows[1]),
    .debounced(debounced_rows[1])
);

debounce #(.HIST_LEN(8)) debounce_row2 (
    .clk(clk),
    .reset(reset),
    .button(rows[2]),
    .debounced(debounced_rows[2])
);

debounce #(.HIST_LEN(8)) debounce_row3 (
    .clk(clk),
    .reset(reset),
    .button(rows[3]),
    .debounced(debounced_rows[3])
);


// Drive power to cols

reg [4:0]   col_update_count;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        col_update_count <= 5'h0;
        counter_cols <= 2'b00;
    end else begin
        col_update_count <= col_update_count + 1;
        if (col_update_count == 5'h0)
           counter_cols <= counter_cols + 1;
    end
end


always @(*) begin
    case(counter_cols)
        2'b00: cols = 4'b0001;
        2'b01: cols = 4'b0010;
        2'b10: cols = 4'b0100;
        2'b11: cols = 4'b1000;
        default: cols = 4'b0000;
    endcase
end



task match_one; begin $display("1 was clicked"); end endtask
task match_two; begin $display("2 was clicked"); end endtask
task match_three; begin $display("3 was clicked"); end endtask
task match_a; begin $display("A was clicked"); end endtask
task match_four; begin $display("4 was clicked"); end endtask
task match_five; begin $display("5 was clicked"); end endtask
task match_six; begin $display("6 was clicked"); end endtask
task match_b; begin $display("B was clicked"); end endtask
task match_seven; begin $display("7 was clicked"); end endtask
task match_eight; begin $display("8 was clicked"); end endtask
task match_nine; begin $display("9 was clicked"); end endtask
task match_c; begin $display("C was clicked"); end endtask
task match_star; begin $display("* was clicked"); end endtask
task match_zero; begin $display("0 was clicked"); end endtask
task match_hashtag; begin $display("# was clicked"); end endtask
task match_d; begin $display("D was clicked"); end endtask



always @(*) begin
    led_a = 1'b0;
    led_b = 1'b0;
    led_c = 1'b0;
    led_d = 1'b0;


    if (cols == 4'b0001 && debounced_rows == 4'b0001) begin
 //       match_one();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0001 && debounced_rows == 4'b0010) begin
 //       match_four();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0001 && debounced_rows == 4'b0100) begin
//        match_seven();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0001 && debounced_rows == 4'b1000) begin
//        match_star();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0010 && debounced_rows == 4'b0001) begin
//        match_two();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0010 && debounced_rows == 4'b0010) begin
//        match_five();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0010 && debounced_rows == 4'b0100) begin
//        match_eight();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0010 && debounced_rows == 4'b1000) begin
//        match_zero();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0100 && debounced_rows == 4'b0001) begin
//        match_three();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0100 && debounced_rows == 4'b0010) begin
//        match_six();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0100 && debounced_rows == 4'b0100) begin
//        match_nine();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b0100 && debounced_rows == 4'b1000) begin
//        match_hashtag();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b1000 && debounced_rows == 4'b0001) begin
//        match_a();
        led_a = 1'b1;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b1000 && debounced_rows == 4'b0010) begin
//        match_b();
        led_a = 1'b0;
        led_b = 1'b1;
        led_c = 1'b0;
        led_d = 1'b0;
    end else if (cols == 4'b1000 && debounced_rows == 4'b0100) begin
//        match_c();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b1;
        led_d = 1'b0;
    end else if (cols == 4'b1000 && debounced_rows == 4'b1000) begin
//        match_d();
        led_a = 1'b0;
        led_b = 1'b0;
        led_c = 1'b0;
        led_d = 1'b1;
    end
end

endmodule
