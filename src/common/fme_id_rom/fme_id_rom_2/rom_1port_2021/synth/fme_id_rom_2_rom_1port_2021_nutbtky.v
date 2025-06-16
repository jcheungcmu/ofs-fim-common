// (C) 2001-2023 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module  fme_id_rom_2_rom_1port_2021_nutbtky  (
    address,
    clock,
    q);

    input  [2:0]  address;
    input    clock;
    output [63:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
    tri1     clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

    wire [63:0] sub_wire0;
    wire [63:0] q = sub_wire0[63:0];

    // Instantiate In System Memory Content Editor IP 
    wire reset_out;
    wire [2:0] ismce_addr;
    wire [0:0]ismce_byteena;
    wire [63:0] ismce_wdata;
    wire ismce_wren;
    wire ismce_rden;
    wire [63:0] ismce_rdata;
    wire ismce_waitrequest;
    wire tck_usr;

    //intel_mce_inst intel_mce_component (
    fme_id_rom_2_rom_1port_intel_mce_2021_iwha2ga  intel_mce_component (
        .clock0           (clock            ),
        .tck_usr          (tck_usr          ),
        .reset_out        (reset_out        ),
        .ismce_addr       (ismce_addr       ),
        .ismce_byteena    (ismce_byteena    ),
        .ismce_wdata      (ismce_wdata      ),
        .ismce_wren       (ismce_wren       ),
        .ismce_rden       (ismce_rden       ),
        .ismce_rdata      (ismce_rdata      ),
        .ismce_waitrequest(ismce_waitrequest) 
    );    
        // Instantiate Arbiter for ISMCE    
    wire [2:0] arb_addr;
    wire [0:0]arb_byteena;
    wire [63:0] arb_wdata;
    wire arb_wren;
    wire arb_rden;
    wire [63:0] arb_rdata;
    fme_id_rom_2_rom_1port_intel_mce_arb_2021_tbyhvui  intel_mce_arb_component (
        .clk              (clock            ),
        .reset            (reset_out        ),
        .uaddr            (address          ),
        .ubyteena         (1'b1        ),
        .uwdata           ('h0              ),
        .urden            (1'b1           ),
        .uwren            (1'b0             ),
        .uaddressstall    (1'b0   ),
        .urdata           (sub_wire0        ),
        .ismce_addr       (ismce_addr       ),
        .ismce_byteena    (ismce_byteena    ),
        .ismce_wdata      (ismce_wdata      ),
        .ismce_wren       (ismce_wren       ),
        .ismce_rden       (ismce_rden       ),
        .ismce_rdata      (ismce_rdata      ),
        .ismce_waitrequest(ismce_waitrequest),
        .addr             (arb_addr         ),
        .byteena          (arb_byteena      ), // unused in ROM mode
        .wdata            (arb_wdata        ),
        .rden             (arb_rden         ),
        .wren             (arb_wren         ),
        .addressstall     (arb_addressstall ),
        .rdata            (arb_rdata        ) 
    );   
    altera_syncram  altera_syncram_component (
                .address_a (arb_addr),
                .clock0 (clock),
                .q_a (arb_rdata),
                .aclr0 (1'b0),
                .aclr1 (1'b0),
                .address2_a (1'b1),
                .address2_b (1'b1),
                .address_b (1'b1),
                .addressstall_a (1'b0),
                .addressstall_b (1'b0),
                .byteena_a (1'b1),
                .byteena_b (1'b1),
                .clock1 (1'b1),
                .clocken0 (1'b1),
                .clocken1 (1'b1),
                .clocken2 (1'b1),
                .clocken3 (1'b1),
                .data_a (arb_wdata),
                .data_b (1'b1),
                .eccencbypass (1'b0),
                .eccencparity (8'b0),
                .eccstatus ( ),
                .q_b ( ),
                .rden_a (1'b1),
                .rden_b (1'b1),
                .sclr (1'b0),
                .wren_a (arb_wren),
                .wren_b (1'b0));
    defparam
        altera_syncram_component.address_aclr_a  = "NONE",
        altera_syncram_component.clock_enable_input_a  = "BYPASS",
        altera_syncram_component.clock_enable_output_a  = "BYPASS",
        altera_syncram_component.init_file = "fme_id_2.mif",
        altera_syncram_component.intended_device_family  = "Agilex 7",
        altera_syncram_component.lpm_type  = "altera_syncram",
        altera_syncram_component.numwords_a  = 8,
        altera_syncram_component.operation_mode  = "ROM",
        altera_syncram_component.outdata_aclr_a  = "NONE",
        altera_syncram_component.outdata_sclr_a  = "NONE",
        altera_syncram_component.outdata_reg_a  = "CLOCK0",
        altera_syncram_component.ram_block_type  = "M20K",
        altera_syncram_component.enable_force_to_zero  = "FALSE",
        altera_syncram_component.widthad_a  = 3,
        altera_syncram_component.width_a  = 64,
        altera_syncram_component.width_byteena_a  = 1;


endmodule


