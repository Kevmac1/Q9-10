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

