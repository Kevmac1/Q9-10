module muxes (
    input logic a_i, b_i, c_i, d_i,
    input logic [1:0] sel4_i,   // Select line for the 4-to-1 mux
    output logic y0_o, y1_o     // Outputs for 2-to-1 and 4-to-1 muxes
);

    logic xor_out;  // XOR gate output

    // XOR gate
    assign xor_out = a_i ^ b_i;

    // 2-to-1 Mux
    always_comb begin
        if (xor_out) begin
            y0_o = d_i;
        end else begin
            y0_o = c_i;
        end
    end

    // 4-to-1 Mux
    always_comb begin
        case (sel4_i)
            2'b00: y1_o = 0;   // First input of 4-to-1 mux is 0
            2'b01: y1_o = c_i; // Second input of 4-to-1 mux is c_i
            2'b10: y1_o = 0;   // Third input of 4-to-1 mux is 0
            2'b11: y1_o = d_i; // Fourth input of 4-to-1 mux is d_i
            default: y1_o = 0; // Default case, typically for safety
        endcase
    end

endmodule


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

