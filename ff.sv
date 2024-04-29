module ff_extended #(
    parameter WIDTH = 4
) (
    input logic clk, 
    input logic rst,
    input logic [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o
);
    logic [WIDTH-1:0] data_d, data_q; // First flip-flop
    logic [WIDTH-1:0] data_1_d, data_1_q; // Second flip-flop
    logic [WIDTH-1:0] data_2_d, data_2_q; // Third flip-flop

    // Assignments
    assign data_o = data_2_q;

    // Combinational logic for each D-input
    always_comb begin
        data_d = data_i; // First D-input
        data_1_d = data_q; // Second D-input
        data_2_d = data_1_q; // Third D-input
    end

    // Asynchronous reset for all flip-flops
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            data_q <= '0; // Reset first Q-output
            data_1_q <= '0; // Reset second Q-output
            data_2_q <= '0; // Reset third Q-output
        end else begin
            data_q <= data_d; // Update first Q-output
            data_1_q <= data_1_d; // Update second Q-output
            data_2_q <= data_2_d; // Update third Q-output
        end
    end
endmodule




