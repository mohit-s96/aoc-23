const std = @import("std");
const day1 = @import("day-1.zig");

pub fn main() !void {
    const day1Answer = try day1.sumOfCalibrationValues();
    std.debug.print("Day 1: {d}\n", .{day1Answer});
}
