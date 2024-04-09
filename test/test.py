# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, with_timeout, Timer, ReadWrite

segments_map = {
    63  : 0,
    6   : 1,
    91  : 2,
    79  : 3,
    102 : 4,
    109 : 5,
    124 : 6,
    7   : 7,
    127 : 8,
    103 : 9,
    }

# the col / row scanning should produce this sequence
correct_sequence = [1, 2, 3, 10, 4, 5, 6, 11, 7, 8, 9, 12, 15, 0, 14, 13]
@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Our example module doesn't use clock and reset, but we show how to use them here anyway.
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 20)

    dut._log.info("Test")
    # the design scans the keys with the columns and reads the rows to detect the key
    # press each col in turn
    for row in range(4):
        for col in range(4):
            # sync to column output
            while dut.uio_out[col].value == 0:
                await ClockCycles(dut.clk, 1)

            # set all rows to zero
            for r in range(4):
                dut.ui_in[r].value = 0
            # except the one we want
            dut.ui_in[row].value = 1

            await ClockCycles(dut.clk, 10) # takes 8 clocks to debounce

            segments = int(dut.uo_out)
            expected_output = correct_sequence[row*4+col]

            # only printing 0 -> 9 on the 7 seg, so ignore 11 -> 15
            decoded = None
            if segments in segments_map:
                decoded = segments_map[segments]
                
            dut._log.info(f"row {row} col {col} = expected output {expected_output} decoded {decoded}")
            if decoded is not None:
                assert decoded == expected_output



