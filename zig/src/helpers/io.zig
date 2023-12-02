const std = @import("std");
const fs = std.fs;

pub fn readFile(path: []u8, allocator: std.mem.Allocator) ![]u8 {
    var path_buffer: [fs.MAX_PATH_BYTES]u8 = undefined;
    const realPath = fs.realpath(path, &path_buffer) catch |err| {
        std.debug.print("An error occurred: {}\n", .{err});
        return error.IOError;
    };

    const file = fs.openFileAbsolute(realPath, .{ .mode = fs.File.OpenMode.read_only }) catch |err| {
        std.debug.print("An error occurred: {}\n", .{err});
        return error.IOError;
    };
    defer file.close();

    const file_stat = try file.stat();
    const buffer_size = file_stat.size;
    const file_buffer = try file.readToEndAlloc(allocator, buffer_size);

    return file_buffer;
}
