package ixia.defold.types;

import defold.Vmath;
import defold.types.Vector3;
import defold.types.Vector4;
import haxe.extern.EitherType;

using defold.Sys;
using lua.Lua;

abstract Rgba(Vector4) from Vector4 to Vector4 {

    @:from public static inline function fromVector3(vector3:Vector3):Rgba {
        return Vmath.vector4(vector3.x, vector3.y, vector3.z, 1);
    }

    @:from public static inline function fromInt(int:Int):Rgba {
        return Vmath.vector4(
            ((int >> 24) & 0xFF) / 255,
            ((int >> 16) & 0xFF) / 255,
            ((int >> 8) & 0xFF) / 255,
            (int & 0xFF) / 255
        );
    }

    public static function fromConfigClearColor():Rgba {
        var rs = "Render.clear_color_red".get_config();
        var gs = "Render.clear_color_green".get_config();
        var bs = "Render.clear_color_blue".get_config();
        var as = "Render.clear_color_alpha".get_config();
        return new Rgba(
            rs != null ? rs.tonumber() : 0,
            gs != null ? gs.tonumber() : 0,
            bs != null ? bs.tonumber() : 0,
            as != null ? as.tonumber() : 1
        );
    }

    @:to public inline function toVector3or4():EitherType<Vector3, Vector4> {
        return cast this;
    }
    
    public inline function new(r:Float, g:Float, b:Float, a:Float) {
        this = Vmath.vector4(r, g, b, a);
    }

    public var r(get, set):Float;
    inline function get_r() return cast this.x;
    inline function set_r(value) return cast this.x = value;

    public var g(get, set):Float;
    inline function get_g() return cast this.y;
    inline function set_g(value) return cast this.y = value;

    public var b(get, set):Float;
    inline function get_b() return cast this.z;
    inline function set_b(value) return cast this.z = value;

    public var a(get, never):Float;
    inline function get_a() return cast this.w;
    inline function set_a(value) return cast this.w = value;
    
}