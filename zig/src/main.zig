const std = @import("std");
const day1 = @import("day-1.zig");
const io = @import("helpers/io.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var args_it = std.process.args();
    var found_f = false;
    var f_arg: ?[]const u8 = null;

    while (args_it.next()) |arg| {
        if (found_f) {
            f_arg = arg;
            break;
        }
        if (std.mem.eql(u8, arg, "-f")) {
            found_f = true;
        }
    }

    if (f_arg == null) std.process.exit(1);

    const buffer: []u8 = try allocator.alloc(u8, f_arg.?.len);
    defer allocator.free(buffer);

    std.mem.copyForwards(u8, buffer, f_arg.?);

    const contents = try io.readFile(buffer, allocator);
    defer allocator.free(contents);
    std.debug.print("{s}", .{contents});
    // var iter = std.mem.splitSequence(u8, file_buffer, "\n");

    // var count: usize = 0;
    // while (iter.next()) |line| : (count += 1) {
    //     std.log.info("{d:>2}: {s}", .{ count, line });
    // }
}
