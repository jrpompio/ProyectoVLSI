//////////////////////////////////////////////////////////////////
//                                                              //
//  Wishbone Arbiter                                            //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Arbitrates between two wishbone masters and 13 wishbone     //
//  slave modules. The ethernet MAC wishbone master is given    //
//  priority over the Amber core.                               //
//                                                              //
//  Author(s):                                                  //
//      - Conor Santifort, csantifort.amber@gmail.com           //
//                                                              //
//////////////////////////////////////////////////////////////////
//                                                              //
// Copyright (C) 2010 Authors and OPENCORES.ORG                 //
//                                                              //
// This source file may be used and distributed without         //
// restriction provided that this copyright statement is not    //
// removed from the file and that any derivative work contains  //
// the original copyright notice and the associated disclaimer. //
//                                                              //
// This source file is free software; you can redistribute it   //
// and/or modify it under the terms of the GNU Lesser General   //
// Public License as published by the Free Software Foundation; //
// either version 2.1 of the License, or (at your option) any   //
// later version.                                               //
//                                                              //
// This source is distributed in the hope that it will be       //
// useful, but WITHOUT ANY WARRANTY; without even the implied   //
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //
// PURPOSE.  See the GNU Lesser General Public License for more //
// details.                                                     //
//                                                              //
// You should have received a copy of the GNU Lesser General    //
// Public License along with this source; if not, download it   //
// from http://www.opencores.org/lgpl.shtml                     //
//                                                              //
//////////////////////////////////////////////////////////////////


module wishbone_arbiter (
input                   i_wb_clk,     // WISHBONE clock

// WISHBONE master 0 - Amber
input       [31:0]      i_m0_wb_adr,
input       [3:0]       i_m0_wb_sel,
input                   i_m0_wb_we,
output      [31:0]      o_m0_wb_dat,
input       [31:0]      i_m0_wb_dat,
input                   i_m0_wb_cyc,
input                   i_m0_wb_stb,
output                  o_m0_wb_ack,
output                  o_m0_wb_err,


// WISHBONE master 1 - Ethmac
input       [31:0]      i_m1_wb_adr,
input       [3:0]       i_m1_wb_sel,
input                   i_m1_wb_we,
output      [31:0]      o_m1_wb_dat,
input       [31:0]      i_m1_wb_dat,
input                   i_m1_wb_cyc,
input                   i_m1_wb_stb,
output                  o_m1_wb_ack,
output                  o_m1_wb_err,


// WISHBONE slave 0 - Ethmac
output      [31:0]      o_s0_wb_adr,
output      [3:0]       o_s0_wb_sel,
output                  o_s0_wb_we,
input       [31:0]      i_s0_wb_dat,
output      [31:0]      o_s0_wb_dat,
output                  o_s0_wb_cyc,
output                  o_s0_wb_stb,
input                   i_s0_wb_ack,
input                   i_s0_wb_err,


// WISHBONE slave 1 - Boot Memory
output      [31:0]      o_s1_wb_adr,
output      [3:0]       o_s1_wb_sel,
output                  o_s1_wb_we,
input       [31:0]      i_s1_wb_dat,
output      [31:0]      o_s1_wb_dat,
output                  o_s1_wb_cyc,
output                  o_s1_wb_stb,
input                   i_s1_wb_ack,
input                   i_s1_wb_err,


// WISHBONE slave 2 - Main Memory
output      [31:0]      o_s2_wb_adr,
output      [3:0]       o_s2_wb_sel,
output                  o_s2_wb_we,
input       [31:0]      i_s2_wb_dat,
output      [31:0]      o_s2_wb_dat,
output                  o_s2_wb_cyc,
output                  o_s2_wb_stb,
input                   i_s2_wb_ack,
input                   i_s2_wb_err,


// WISHBONE slave 3 - UART 0
output      [31:0]      o_s3_wb_adr,
output      [3:0]       o_s3_wb_sel,
output                  o_s3_wb_we,
input       [31:0]      i_s3_wb_dat,
output      [31:0]      o_s3_wb_dat,
output                  o_s3_wb_cyc,
output                  o_s3_wb_stb,
input                   i_s3_wb_ack,
input                   i_s3_wb_err,


// WISHBONE slave 4 - UART 1
output      [31:0]      o_s4_wb_adr,
output      [3:0]       o_s4_wb_sel,
output                  o_s4_wb_we,
input       [31:0]      i_s4_wb_dat,
output      [31:0]      o_s4_wb_dat,
output                  o_s4_wb_cyc,
output                  o_s4_wb_stb,
input                   i_s4_wb_ack,
input                   i_s4_wb_err,


// WISHBONE slave 5 - Test Module
output      [31:0]      o_s5_wb_adr,
output      [3:0]       o_s5_wb_sel,
output                  o_s5_wb_we,
input       [31:0]      i_s5_wb_dat,
output      [31:0]      o_s5_wb_dat,
output                  o_s5_wb_cyc,
output                  o_s5_wb_stb,
input                   i_s5_wb_ack,
input                   i_s5_wb_err,


// WISHBONE slave 6 - Timer Module
output      [31:0]      o_s6_wb_adr,
output      [3:0]       o_s6_wb_sel,
output                  o_s6_wb_we,
input       [31:0]      i_s6_wb_dat,
output      [31:0]      o_s6_wb_dat,
output                  o_s6_wb_cyc,
output                  o_s6_wb_stb,
input                   i_s6_wb_ack,
input                   i_s6_wb_err,


 // WISHBONE slave 7 - Interrupt Controller AMBER 0
output      [31:0]      o_s7_wb_adr,
output      [3:0]       o_s7_wb_sel,
output                  o_s7_wb_we,
input       [31:0]      i_s7_wb_dat,
output      [31:0]      o_s7_wb_dat,
output                  o_s7_wb_cyc,
output                  o_s7_wb_stb,
input                   i_s7_wb_ack,
input                   i_s7_wb_err,

 // WISHBONE slave 8 - Interrupt Controller AMBER 1
output      [31:0]      o_s8_wb_adr,
output      [3:0]       o_s8_wb_sel,
output                  o_s8_wb_we,
input       [31:0]      i_s8_wb_dat,
output      [31:0]      o_s8_wb_dat,
output                  o_s8_wb_cyc,
output                  o_s8_wb_stb,
input                   i_s8_wb_ack,
input                   i_s8_wb_err
);

`include "memory_configuration.v"

reg         m0_wb_cyc_r = 'd0;
reg         m1_wb_cyc_r = 'd0;
wire        m0_in_cycle;
wire        m1_in_cycle;
wire        current_master;
reg         current_master_r = 'd0;
wire        next_master;
wire        select_master;
wire [3:0]  current_slave;

wire [31:0] master_adr;
wire [3:0]  master_sel;
wire        master_we;
wire [31:0] master_wdat;
wire        master_cyc;
wire        master_stb;
wire [31:0] master_rdat;
wire        master_ack;
wire        master_err;
   
// Arbitrate between m0 and m1. Ethmac (m0) always gets priority
assign next_master    = i_m0_wb_cyc ? 1'd0 : 1'd1;

// Use cyc signal for arbitration so block accesses are not split up
assign m0_in_cycle    = m0_wb_cyc_r && i_m0_wb_cyc;
assign m1_in_cycle    = m1_wb_cyc_r && i_m1_wb_cyc;

// only select a new bus master when the current bus master
// de-asserts the cyc signal
assign select_master  = current_master_r ? !m1_in_cycle : !m0_in_cycle;
assign current_master = select_master ? next_master : current_master_r;


always @( posedge i_wb_clk )
    begin
    current_master_r    <= current_master;
    m0_wb_cyc_r         <= i_m0_wb_cyc;
    m1_wb_cyc_r         <= i_m1_wb_cyc;
    end


// Arbitrate between slaves
assign current_slave = in_ethmac   ( master_adr ) ? 4'd0  :  // Ethmac
                       in_boot_mem ( master_adr ) ? 4'd1  :  // Boot memory
                       in_main_mem ( master_adr ) ? 4'd2  :  // Main memory
                       in_uart0    ( master_adr ) ? 4'd3  :  // UART 0
                       in_uart1    ( master_adr ) ? 4'd4  :  // UART 1
                       in_test     ( master_adr ) ? 4'd5  :  // Test Module
                       in_tm       ( master_adr ) ? 4'd6  :  // Timer Module
                       in_ic       ( master_adr ) ? 4'd7  :  // Interrupt Controller AMBER 0
                       in_ic2      ( master_adr ) ? 4'd8  :  // Interrupt Controller AMBER 1
                                                    4'd2  ;  // default to main memory


assign master_adr   = current_master ? i_m1_wb_adr : i_m0_wb_adr ;
// Switch endianess of ethmac Master
assign master_sel   = current_master ? i_m1_wb_sel : {i_m0_wb_sel[0], i_m0_wb_sel[1], 
                                                      i_m0_wb_sel[2], i_m0_wb_sel[3]};
assign master_wdat  = current_master ? i_m1_wb_dat : {i_m0_wb_dat[7:0],  i_m0_wb_dat[15:8],
                                                      i_m0_wb_dat[23:16],i_m0_wb_dat[31:24]} ;
assign master_we    = current_master ? i_m1_wb_we  : i_m0_wb_we  ;
assign master_cyc   = current_master ? i_m1_wb_cyc : i_m0_wb_cyc ;
assign master_stb   = current_master ? i_m1_wb_stb : i_m0_wb_stb ;


// Ethmac Slave outputs
assign o_s0_wb_adr  = master_adr;
assign o_s0_wb_dat  = master_wdat;
assign o_s0_wb_sel  = master_sel;
assign o_s0_wb_we   = current_slave == 4'd0 ? master_we  : 1'd0;
assign o_s0_wb_cyc  = current_slave == 4'd0 ? master_cyc : 1'd0;
assign o_s0_wb_stb  = current_slave == 4'd0 ? master_stb : 1'd0;

// Boot Memory outputs
assign o_s1_wb_adr  = master_adr;
assign o_s1_wb_dat  = master_wdat;
assign o_s1_wb_sel  = master_sel;
assign o_s1_wb_we   = current_slave == 4'd1 ? master_we  : 1'd0;
assign o_s1_wb_cyc  = current_slave == 4'd1 ? master_cyc : 1'd0;
assign o_s1_wb_stb  = current_slave == 4'd1 ? master_stb : 1'd0;

// Main Memory Outputs
assign o_s2_wb_adr  = master_adr;
assign o_s2_wb_dat  = master_wdat;
assign o_s2_wb_sel  = master_sel;
assign o_s2_wb_we   = current_slave == 4'd2 ? master_we  : 1'd0;
assign o_s2_wb_cyc  = current_slave == 4'd2 ? master_cyc : 1'd0;
assign o_s2_wb_stb  = current_slave == 4'd2 ? master_stb : 1'd0;

// UART0 Outputs
assign o_s3_wb_adr  = master_adr;
assign o_s3_wb_dat  = master_wdat;
assign o_s3_wb_sel  = master_sel;
assign o_s3_wb_we   = current_slave == 4'd3 ? master_we  : 1'd0;
assign o_s3_wb_cyc  = current_slave == 4'd3 ? master_cyc : 1'd0;
assign o_s3_wb_stb  = current_slave == 4'd3 ? master_stb : 1'd0;

// UART1 Outputs
assign o_s4_wb_adr  = master_adr;
assign o_s4_wb_dat  = master_wdat;
assign o_s4_wb_sel  = master_sel;
assign o_s4_wb_we   = current_slave == 4'd4 ? master_we  : 1'd0;
assign o_s4_wb_cyc  = current_slave == 4'd4 ? master_cyc : 1'd0;
assign o_s4_wb_stb  = current_slave == 4'd4 ? master_stb : 1'd0;

// Test Module Outputs
assign o_s5_wb_adr  = master_adr;
assign o_s5_wb_dat  = master_wdat;
assign o_s5_wb_sel  = master_sel;
assign o_s5_wb_we   = current_slave == 5'd5 ? master_we  : 1'd0;
assign o_s5_wb_cyc  = current_slave == 5'd5 ? master_cyc : 1'd0;
assign o_s5_wb_stb  = current_slave == 5'd5 ? master_stb : 1'd0;

// Timers Outputs
assign o_s6_wb_adr  = master_adr;
assign o_s6_wb_dat  = master_wdat;
assign o_s6_wb_sel  = master_sel;
assign o_s6_wb_we   = current_slave == 6'd6 ? master_we  : 1'd0;
assign o_s6_wb_cyc  = current_slave == 6'd6 ? master_cyc : 1'd0;
assign o_s6_wb_stb  = current_slave == 6'd6 ? master_stb : 1'd0;

// Interrupt Controller AMBER 0
assign o_s7_wb_adr  = master_adr;
assign o_s7_wb_dat  = master_wdat;
assign o_s7_wb_sel  = master_sel;
assign o_s7_wb_we   = current_slave == 4'd7 ? master_we  : 1'd0;
assign o_s7_wb_cyc  = current_slave == 4'd7 ? master_cyc : 1'd0;
assign o_s7_wb_stb  = current_slave == 4'd7 ? master_stb : 1'd0;

// Interrupt Controller AMBER 1
assign o_s8_wb_adr  = master_adr;
assign o_s8_wb_dat  = master_wdat;
assign o_s8_wb_sel  = master_sel;
assign o_s8_wb_we   = current_slave == 4'd8 ? master_we  : 1'd0;
assign o_s8_wb_cyc  = current_slave == 4'd8 ? master_cyc : 1'd0;
assign o_s8_wb_stb  = current_slave == 4'd8 ? master_stb : 1'd0;

// Master Outputs
assign master_rdat  = current_slave == 4'd0  ? i_s0_wb_dat  :
                      current_slave == 4'd1  ? i_s1_wb_dat  :
                      current_slave == 4'd2  ? i_s2_wb_dat  :
                      current_slave == 4'd3  ? i_s3_wb_dat  :
                      current_slave == 4'd4  ? i_s4_wb_dat  :
                      current_slave == 4'd5  ? i_s5_wb_dat  :
                      current_slave == 4'd6  ? i_s6_wb_dat  :
                      current_slave == 4'd7  ? i_s7_wb_dat  :
                      current_slave == 4'd8  ? i_s8_wb_dat  :
                                               i_s2_wb_dat  ;


assign master_ack   = current_slave == 4'd0  ? i_s0_wb_ack  :
                      current_slave == 4'd1  ? i_s1_wb_ack  :
                      current_slave == 4'd2  ? i_s2_wb_ack  :
                      current_slave == 4'd3  ? i_s3_wb_ack  :
                      current_slave == 4'd4  ? i_s4_wb_ack  :
                      current_slave == 4'd5  ? i_s5_wb_ack  :
                      current_slave == 4'd6  ? i_s6_wb_ack  :
                      current_slave == 4'd7  ? i_s7_wb_ack  :
                      current_slave == 4'd8  ? i_s8_wb_ack  :
                                               i_s2_wb_ack  ; 


assign master_err   = current_slave == 4'd0  ? i_s0_wb_err  :
                      current_slave == 4'd1  ? i_s1_wb_err  :
                      current_slave == 4'd2  ? i_s2_wb_err  :
                      current_slave == 4'd3  ? i_s3_wb_err  :
                      current_slave == 4'd4  ? i_s4_wb_err  :
                      current_slave == 4'd5  ? i_s5_wb_err  :
                      current_slave == 4'd6  ? i_s6_wb_err  :
                      current_slave == 4'd7  ? i_s7_wb_err  :
                      current_slave == 4'd8  ? i_s8_wb_err  :
                                               i_s2_wb_err  ; 


// Ethmac Master Outputs
// Switch endianess of ethmac Master
assign o_m0_wb_dat  = {master_rdat[7:0], master_rdat[15:8],
                       master_rdat[23:16],master_rdat[31:24]};
assign o_m0_wb_ack  = current_master  ? 1'd0 : master_ack ;
assign o_m0_wb_err  = current_master  ? 1'd0 : master_err ;

// Amber Master Outputs
assign o_m1_wb_dat  = master_rdat;
assign o_m1_wb_ack  = current_master  ?  master_ack : 1'd0 ;
assign o_m1_wb_err  = current_master  ?  master_err : 1'd0 ;

endmodule


// -----------------------------------------------------------------------------
// wb_rr_arb2: Two-master -> one-master Wishbone round-robin arbiter
// - Classic Wishbone subset: ADR, SEL, WE, DAT_W, CYC, STB, DAT_R, ACK, ERR
// - Holds grant for a master while CYC=1 (atomic bus cycle)
// - When idle and both request simultaneously, alternates priority
// -----------------------------------------------------------------------------
// Ports naming matches the sketch:
//   A = CPU0 (e.g., m_wb_*[1])
//   B = CPU1 (e.g., m_wb_*[2])
//   M = merged master toward your existing big arbiter (M1 port)
// -----------------------------------------------------------------------------
module wb_rr_arb2 (
    input  wire         i_clk,
    input  wire         i_rst,      // active-high synchronous reset (tie to sys_rst)

    // Master A (CPU0)
    input  wire [31:0]  i_a_adr,
    input  wire [3:0]   i_a_sel,
    input  wire         i_a_we,
    input  wire [31:0]  i_a_dat_w,
    input  wire         i_a_cyc,
    input  wire         i_a_stb,
    output wire [31:0]  o_a_dat_r,
    output wire         o_a_ack,
    output wire         o_a_err,

    // Master B (CPU1)
    input  wire [31:0]  i_b_adr,
    input  wire [3:0]   i_b_sel,
    input  wire         i_b_we,
    input  wire [31:0]  i_b_dat_w,
    input  wire         i_b_cyc,
    input  wire         i_b_stb,
    output wire [31:0]  o_b_dat_r,
    output wire         o_b_ack,
    output wire         o_b_err,

    // Merged master toward the main fabric
    output reg  [31:0]  o_m_adr,
    output reg  [3:0]   o_m_sel,
    output reg          o_m_we,
    output reg  [31:0]  o_m_dat_w,
    output reg          o_m_cyc,
    output reg          o_m_stb,
    input  wire [31:0]  i_m_dat_r,
    input  wire         i_m_ack,
    input  wire         i_m_err
);

    // -------------------------------------------------------------------------
    // Request / grant
    // -------------------------------------------------------------------------
    wire req_a = i_a_cyc;  // use CYC to request/own bus
    wire req_b = i_b_cyc;

    localparam GNT_NONE = 2'd0,
               GNT_A    = 2'd1,
               GNT_B    = 2'd2;

    reg [1:0] grant, grant_n;
    reg       last_winner; // 0 => last was A, 1 => last was B (for round-robin)

    // Next-state logic
    always @* begin
        grant_n = grant;

        case (grant)
            GNT_NONE: begin
                if (req_a && !req_b)        grant_n = GNT_A;
                else if (!req_a && req_b)   grant_n = GNT_B;
                else if (req_a && req_b)    grant_n = (last_winner == 1'b0) ? GNT_B : GNT_A;
                else                        grant_n = GNT_NONE;
            end

            GNT_A: begin
                // Keep bus while A keeps CYC asserted
                if (!req_a) grant_n = GNT_NONE;
            end

            GNT_B: begin
                if (!req_b) grant_n = GNT_NONE;
            end

            default: grant_n = GNT_NONE;
        endcase
    end

    // State / winner tracking
    always @(posedge i_clk) begin
        if (i_rst) begin
            grant       <= GNT_NONE;
            last_winner <= 1'b1; // prefer A on the very first simultaneous request
        end else begin
            grant <= grant_n;

            // Update last_winner when a granted cycle ends
            if (grant == GNT_A && !req_a) last_winner <= 1'b0;
            else if (grant == GNT_B && !req_b) last_winner <= 1'b1;
            // If moving from NONE to a grant due to a tie, record immediately
            else if (grant == GNT_NONE && grant_n == GNT_A && req_a && req_b)
                last_winner <= 1'b0;
            else if (grant == GNT_NONE && grant_n == GNT_B && req_a && req_b)
                last_winner <= 1'b1;
        end
    end

    // -------------------------------------------------------------------------
    // Mux masters -> merged bus
    // -------------------------------------------------------------------------
    always @* begin
        case (grant)
            GNT_A: begin
                o_m_adr   = i_a_adr;
                o_m_sel   = i_a_sel;
                o_m_we    = i_a_we;
                o_m_dat_w = i_a_dat_w;
                o_m_cyc   = i_a_cyc;
                o_m_stb   = i_a_stb;
            end

            GNT_B: begin
                o_m_adr   = i_b_adr;
                o_m_sel   = i_b_sel;
                o_m_we    = i_b_we;
                o_m_dat_w = i_b_dat_w;
                o_m_cyc   = i_b_cyc;
                o_m_stb   = i_b_stb;
            end

            default: begin
                o_m_adr   = 32'h0;
                o_m_sel   = 4'h0;
                o_m_we    = 1'b0;
                o_m_dat_w = 32'h0;
                o_m_cyc   = 1'b0;
                o_m_stb   = 1'b0;
            end
        endcase
    end

    // -------------------------------------------------------------------------
    // Demux merged bus returns -> granted master only
    // Non-granted master sees ACK/ERR low; DAT_R don't care (0)
    // -------------------------------------------------------------------------
    assign o_a_dat_r = (grant == GNT_A) ? i_m_dat_r : 32'h0;
    assign o_a_ack   = (grant == GNT_A) ? i_m_ack   : 1'b0;
    assign o_a_err   = (grant == GNT_A) ? i_m_err   : 1'b0;

    assign o_b_dat_r = (grant == GNT_B) ? i_m_dat_r : 32'h0;
    assign o_b_ack   = (grant == GNT_B) ? i_m_ack   : 1'b0;
    assign o_b_err   = (grant == GNT_B) ? i_m_err   : 1'b0;

endmodule
