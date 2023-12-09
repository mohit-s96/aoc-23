const std = @import("std");

pub fn extractCliArg(match: []const u8) ?[]const u8 {
    var args_it = std.process.args();
    var found_f = false;
    var argValue: ?[]const u8 = null;

    while (args_it.next()) |arg| {
        if (found_f) {
            argValue = arg;
            break;
        }
        if (std.mem.eql(u8, arg, match)) {
            found_f = true;
        }
    }

    return argValue;
}
