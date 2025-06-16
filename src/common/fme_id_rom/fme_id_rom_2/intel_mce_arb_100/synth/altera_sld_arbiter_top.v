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


//--------------------------------------------------------------------
//--
//--  Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
//--
//--  Your use of Altera Corporation's design tools, logic functions  
//--  and other software and tools, and its AMPP partner logic  
//--  functions, and any output files from any of the foregoing  
//--  (including device programming or simulation files), and any  
//--  associated documentation or information are expressly subject  
//--  to the terms and conditions of the Altera Program License  
//--  Subscription Agreement, Altera MegaCore Function License  
//--  Agreement, or other applicable license agreement, including,  
//--  without limitation, that your use is for the sole purpose of  
//--  programming logic devices manufactured by Altera and sold by  
//--  Altera or its authorized distributors.  Please refer to the  
//--  applicable agreement for further details. 
//--
//--------------------------------------------------------------------

//-------------------------------------------------------------------
// Filename    : altera_sld_arbiter_top.v
//
// Description : Muxing user_read/write and ismce_read/write with user signals has priority.
//
// Limitation  : Meant for Stratix 10 and beyond
//
//-------------------------------------------------------------------

module altera_sld_arbiter_top
    #(
        parameter LATENCY = 2,
        parameter DATA_WIDTH = 32,
        parameter WIDTHAD = 8,
        parameter BYTE_ENABLE_WIDTH = 1
    )
    (
        // Clocks / Reset
        input clk,
        // reset not used but keep for future    
        input reset,

        // User mem signals
        input[WIDTHAD-1:0] uaddr,
        input[BYTE_ENABLE_WIDTH-1:0] ubyteena,
        input[DATA_WIDTH-1:0] uwdata,
        input urden,
        input uwren,
        input uaddressstall,
        output[DATA_WIDTH-1:0] urdata,

        // ISMCE mem signals to arbiter
        input [WIDTHAD-1:0]  ismce_addr,
        input [BYTE_ENABLE_WIDTH-1:0] ismce_byteena,
        input [DATA_WIDTH-1:0]  ismce_wdata,
        input                   ismce_wren,
        input                   ismce_rden,
        output[DATA_WIDTH-1:0]  ismce_rdata,
        output                  ismce_waitrequest,

        // Ram signals
        output[WIDTHAD-1:0] addr,
        output[BYTE_ENABLE_WIDTH-1:0] byteena,
        output[DATA_WIDTH-1:0] wdata,
        output rden,
        output wren,
        output addressstall,
        input[DATA_WIDTH-1:0] rdata
    );

altera_sld_arbiter #(
        .LATENCY           (LATENCY          ),
        .DATA_WIDTH        (DATA_WIDTH       ),
        .WIDTHAD           (WIDTHAD          ),
        .BYTE_ENABLE_WIDTH (BYTE_ENABLE_WIDTH)
    ) altera_sld_arbiter_inst  (
        .clk               (clk              ),
        .reset             (reset            ),
        .uaddr             (uaddr            ),
        .ubyteena          (ubyteena         ),
        .uwdata            (uwdata           ),
        .urden             (urden            ),
        .uwren             (uwren            ),
        .uaddressstall     (uaddressstall    ),
        .urdata            (urdata           ),
        .ismce_addr        (ismce_addr       ),
        .ismce_byteena     (ismce_byteena    ),
        .ismce_wdata       (ismce_wdata      ),
        .ismce_wren        (ismce_wren       ),
        .ismce_rden        (ismce_rden       ),
        .ismce_rdata       (ismce_rdata      ),
        .ismce_waitrequest (ismce_waitrequest),
        .addr              (addr             ),
        .byteena           (byteena          ),
        .wdata             (wdata            ),
        .rden              (rden             ),
        .wren              (wren             ),
        .addressstall      (addressstall     ),
        .rdata             (rdata            )
    );
    

endmodule 
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "QIVWpxzUfGDyjpF24xYkgJT0rwiaq5jLMpIIYYVR8BEH/FSLg7c9DffhYw4Pqa3cV+tovBwM6fMqFYUChMDdFPuTzRFicw/HNpW5Cb2ckvT+h8mfSB1jLutRLAleHSNQU9E56Yn2Un4voN3gYtEWXGBHxvUCbwvP2uFthPfgXIv94bueC43AJ3Q8chlCX/Bos1sSQD1D/8UJWXJi6Fx1UlH364UPnhubCMgninMfWburxxJ+qKdCZJwDjwzpxyfsSQBD3BYnE8JF1d5ABx2DVBPRTNWksQCpmvmE4/7xONa80oERCn624wmV4IoSePvL6F13TI7cki9X7Veyza80eXuJlQBLM/HcV8Y686sw1mQIuv+INVgKlcD2on4PIBjZZwcU5CQBtKwI2oPgVdO1JpEdPFqS2wwcKtTS+FwggiHSbblSVCjdi3yCpmwGy40A4QIeZ30UxHp93QUFDXkWPOy66mE3zFV0DbsHRHJw3E09DQBsiBE8HiyI4wf7fDFyTgep2EEzDeKgMbFVtOsL/Y/VU/OVxAHX8VMIlR6+RjKSGsr8Q1eH/cEE+HdYjAFk9M7Kut5+3QQAsvUmNfaPqBEIXOwHFRxdtcK5E9qoZcrBt5bfoTuk47mwx8dFdTS9fyh1v8raapPchemOqBhIpzyGs7ij4J9CkH1LAwTFvKNVX9aknbqnbhnN5BZd/8udqFyvf71K36+AR0K6+80z269KAMbRCWIQ/q1ynDFV1ErSpH1yF/A/qiQY0Aur3tIeAfI+TegfWodSwJllxs6nyY/tdnei1dIwiOA0mIe1lF/pIllgasH5oAdZX93LO3LX1up4YYV8kxSnjZYK7jZsgd3h8+MIkg4ONmQQCw846mnL4Wofs7k7loeYL6Y9ikuB0cBDhfDRcPYxgaD4ZMeFoCDcYITFt2W1HdohIIq1pja1bhsLXbLMPEBDSGJ0l846yhfLgFtPEr1hpPMhFNmZH//oA1DPaSO4+8dTLo3CL8+QUp/kPuM7mR88NY1lIzes"
`endif