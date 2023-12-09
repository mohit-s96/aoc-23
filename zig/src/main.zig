const std = @import("std");
const day1 = @import("day-1.zig");
const io = @import("helpers/io.zig");
const cli = @import("helpers/cli.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const argValue = cli.extractCliArg("-f");
    if (argValue == null) std.process.exit(1);

    const contents = try io.readFile(argValue.?, allocator);
    defer allocator.free(contents);
    std.debug.print("{s}", .{contents});
    // var iter = std.mem.splitSequence(u8, file_buffer, "\n");

    // var count: usize = 0;
    // while (iter.next()) |line| : (count += 1) {
    //     std.log.info("{d:>2}: {s}", .{ count, line });
    // }
}
