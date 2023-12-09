const std = @import("std");
const io = @import("helpers/io.zig");
const cli = @import("helpers/cli.zig");

fn charToDigit(c: u8) ?u8 {
    return switch (c) {
        '0'...'9' => c - '0',
        else => null,
    };
}

fn parseValue(value: []const u8, allocator: std.mem.Allocator) !std.ArrayList(u8) {
    var arrayList = std.ArrayList(u8).init(allocator);
    for (value) |v| {
        const digit = charToDigit(v);
        if (digit != null) {
            try arrayList.append(digit.?);
        }
    }
    return arrayList;
}

pub fn sumOfCalibrationValues() !usize {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const argValue = cli.extractCliArg("-f");
    if (argValue == null) std.process.exit(1);

    const contents = try io.readFile(argValue.?, allocator);
    defer allocator.free(contents);

    var iter = std.mem.splitSequence(u8, contents, "\n");

    var count: usize = 0;
    while (iter.next()) |line| {
        const a = try parseValue(line, allocator);
        defer a.deinit();
        const first = a.items[0];
        const last = a.items[a.items.len - 1];
        count = count + (first * 10 + last);
    }
    return count;
}
