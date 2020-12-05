package com.goodgamestudios.graphics.utils
{
   import com.goodgamestudios.math.MathBase;
   import com.goodgamestudios.math.Random;
   import com.goodgamestudios.math.Range;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class ColorUtils
   {
      
      public static const RGB_MAX:uint = 255;
      
      public static const HUE_MAX:uint = 360;
      
      public static const PCT_MAX:uint = 100;
       
      
      public function ColorUtils()
      {
         super();
         throw new Error("ColorUtils is a static class and cannot be instantiated.");
      }
      
      public static function getColor(param1:DisplayObject, param2:uint = 0, param3:uint = 0, param4:Boolean = false) : uint
      {
         var _loc5_:BitmapData = new BitmapData(param1.width,param1.height);
         _loc5_.draw(param1);
         var _loc6_:uint = !param4?uint(_loc5_.getPixel(int(param2),int(param3))):uint(_loc5_.getPixel32(int(param2),int(param3)));
         _loc5_.dispose();
         return _loc6_;
      }
      
      public static function setColor(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      public static function randomColor() : uint
      {
         return Random.hexColor();
      }
      
      public static function invertColor(param1:DisplayObject) : void
      {
         var _loc2_:Object = ColorUtils.getTransform(param1);
         ColorUtils.setTransform(param1,{
            "ra":-_loc2_["ra"],
            "ga":-_loc2_["ga"],
            "ba":-_loc2_["ba"],
            "rb":255 - _loc2_["rb"],
            "gb":255 - _loc2_["gb"],
            "bb":255 - _loc2_["bb"]
         });
      }
      
      public static function resetColor(param1:DisplayObject) : void
      {
         ColorUtils.setTransform(param1,{
            "ra":100,
            "ga":100,
            "ba":100,
            "rb":0,
            "gb":0,
            "bb":0
         });
      }
      
      public static function getTransform(param1:DisplayObject) : Object
      {
         var _loc2_:ColorTransform = param1.transform.colorTransform;
         return {
            "ra":_loc2_.redMultiplier * 100,
            "rb":_loc2_.redOffset,
            "ga":_loc2_.greenMultiplier * 100,
            "gb":_loc2_.greenOffset,
            "ba":_loc2_.blueMultiplier * 100,
            "bb":_loc2_.blueOffset,
            "aa":_loc2_.alphaMultiplier * 100,
            "ab":_loc2_.alphaOffset
         };
      }
      
      public static function setTransform(param1:DisplayObject, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc5_:ColorTransform = null;
         var _loc3_:Object = {
            "ra":100,
            "rb":0,
            "ga":100,
            "gb":0,
            "ba":100,
            "bb":0,
            "aa":100,
            "ab":0
         };
         for(_loc4_ in param2)
         {
            _loc3_[_loc4_] = param2[_loc4_];
         }
         _loc5_ = new ColorTransform(_loc3_["ra"] * 0.01,_loc3_["ga"] * 0.01,_loc3_["ba"] * 0.01,_loc3_["aa"] * 0.01,_loc3_["rb"],_loc3_["gb"],_loc3_["bb"],_loc3_["ab"]);
         param1.transform.colorTransform = _loc5_;
      }
      
      public static function toColor(param1:String) : uint
      {
         if(param1.substr(0,2) == "0x")
         {
            param1 = param1.substr(2);
         }
         else if(param1.substr(0,1) == "#")
         {
            param1 = param1.substr(1);
         }
         return parseInt(param1,16);
      }
      
      public static function toHexString(param1:uint) : String
      {
         return "0x" + param1.toString(16).toUpperCase();
      }
      
      public static function toHTML(param1:uint) : String
      {
         return "#" + param1.toString(16).toUpperCase();
      }
      
      public static function HueToRGB(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         while(param3 < 0)
         {
            param3 = param3 + HUE_MAX;
         }
         _loc7_ = Math.floor(param3 / 60);
         _loc6_ = (param3 - _loc7_ * 60) / 60;
         _loc7_ = _loc7_ % 6;
         _loc4_ = param1 + (param2 - param1) * _loc6_;
         _loc5_ = param2 - (param2 - param1) * _loc6_;
         switch(_loc7_)
         {
            case 0:
               return {
                  "r":param2,
                  "g":_loc4_,
                  "b":param1
               };
            case 1:
               return {
                  "r":_loc5_,
                  "g":param2,
                  "b":param1
               };
            case 2:
               return {
                  "r":param1,
                  "g":param2,
                  "b":_loc4_
               };
            case 3:
               return {
                  "r":param1,
                  "g":_loc5_,
                  "b":param2
               };
            case 4:
               return {
                  "r":_loc4_,
                  "g":param1,
                  "b":param2
               };
            case 5:
               return {
                  "r":param2,
                  "g":param1,
                  "b":_loc5_
               };
            default:
               return null;
         }
      }
      
      public static function RGBToHue(param1:Number, param2:Number, param3:Number) : uint
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc7_ = Math.max(param1,Math.max(param2,param3));
         _loc5_ = Math.min(param1,Math.min(param2,param3));
         if(_loc7_ - _loc5_ == 0)
         {
            return 0;
         }
         _loc6_ = Range.center(param1,param2,param3);
         if(param1 == _loc7_)
         {
            if(param3 == _loc5_)
            {
               _loc8_ = 0;
            }
            else
            {
               _loc8_ = 5;
            }
         }
         else if(param2 == _loc7_)
         {
            if(param3 == _loc5_)
            {
               _loc8_ = 1;
            }
            else
            {
               _loc8_ = 2;
            }
         }
         else if(param1 == _loc5_)
         {
            _loc8_ = 3;
         }
         else
         {
            _loc8_ = 4;
         }
         if(_loc8_ % 2 == 0)
         {
            _loc4_ = _loc6_ - _loc5_;
         }
         else
         {
            _loc4_ = _loc7_ - _loc6_;
         }
         _loc4_ = _loc4_ / (_loc7_ - _loc5_);
         return 60 * (_loc8_ + _loc4_);
      }
      
      public static function RGBtoHSL(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = 0;
         _loc5_ = Math.max(param1,Math.max(param2,param3));
         _loc4_ = Math.min(param1,Math.min(param2,param3));
         _loc7_ = (_loc4_ + _loc5_) * 0.5;
         if(_loc7_ == 0)
         {
            return {
               "h":_loc9_,
               "l":0,
               "s":1
            };
         }
         _loc6_ = (_loc5_ - _loc4_) * 0.5;
         if(_loc7_ < 0.5)
         {
            _loc8_ = _loc6_ / _loc7_;
         }
         else
         {
            _loc8_ = _loc6_ / (1 - _loc7_);
         }
         _loc9_ = RGBToHue(param1,param2,param3);
         return {
            "h":_loc9_,
            "l":_loc7_,
            "s":_loc8_
         };
      }
      
      public static function HSLtoRGB(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = NaN;
         if(param2 < 0.5)
         {
            _loc4_ = param3 * param2;
         }
         else
         {
            _loc4_ = param3 * (1 - param2);
         }
         return HueToRGB(param2 - _loc4_,param2 + _loc4_,param1);
      }
      
      public static function RGBtoHSV(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = 0;
         _loc5_ = Math.max(param1,Math.max(param2,param3));
         _loc4_ = Math.min(param1,Math.min(param2,param3));
         if(_loc5_ == 0)
         {
            return {
               "h":0,
               "s":0,
               "v":0
            };
         }
         _loc7_ = _loc5_;
         _loc6_ = (_loc5_ - _loc4_) / _loc5_;
         _loc8_ = RGBToHue(param1,param2,param3);
         return {
            "h":_loc8_,
            "s":_loc6_,
            "v":_loc7_
         };
      }
      
      public static function HSVtoRGB(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = (1 - param2) * param3;
         return HueToRGB(_loc4_,param3,param1);
      }
      
      public static function HSVtoHSL(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Object = HSVtoRGB(param1,param2,param3);
         return RGBtoHSL(_loc4_.r,_loc4_.g,_loc4_.b);
      }
      
      public static function HSLtoHSV(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Object = HSLtoRGB(param1,param2,param3);
         return RGBtoHSV(_loc4_.r,_loc4_.g,_loc4_.b);
      }
      
      public static function setRGBComponent(param1:DisplayObject, param2:Number, param3:Number, param4:Number) : void
      {
         param2 = MathBase.limit(param2,0,RGB_MAX,false);
         param3 = MathBase.limit(param3,0,RGB_MAX,false);
         param4 = MathBase.limit(param4,0,RGB_MAX,false);
         setColor(param1,hexFromComponents(param2,param3,param4));
      }
      
      public static function getRGBComponent(param1:DisplayObject, param2:uint = 0, param3:uint = 0) : Object
      {
         var _loc4_:Object = componentsFromHex(getColor(param1,param2,param3));
         return {
            "r":_loc4_.r,
            "g":_loc4_.g,
            "b":_loc4_.b
         };
      }
      
      public static function setHSLComponent(param1:DisplayObject, param2:Number, param3:Number, param4:Number) : void
      {
         param2 = MathBase.limit(param2,0,HUE_MAX,true);
         param3 = MathBase.limit(param3,0,PCT_MAX,false) / PCT_MAX;
         param4 = MathBase.limit(param4,0,PCT_MAX,false) / PCT_MAX;
         var _loc5_:Object = HSLtoRGB(param2,param3,param4);
         setColor(param1,hexFromPercentages(_loc5_));
      }
      
      public static function getHSLComponent(param1:DisplayObject, param2:uint = 0, param3:uint = 0) : Object
      {
         var _loc4_:Object = componentsFromHex(getColor(param1,param2,param3));
         _loc4_.r = _loc4_.r / 256;
         _loc4_.g = _loc4_.g / 256;
         _loc4_.b = _loc4_.b / 256;
         var _loc5_:Object = RGBtoHSL(_loc4_.r,_loc4_.g,_loc4_.b);
         _loc5_.h = Math.round(_loc5_.h);
         _loc5_.l = Math.round(_loc5_.l * PCT_MAX);
         _loc5_.s = Math.round(_loc5_.s * PCT_MAX);
         return _loc5_;
      }
      
      public static function setHSVComponent(param1:DisplayObject, param2:Number, param3:Number, param4:Number) : void
      {
         param2 = MathBase.limit(param2,0,HUE_MAX,true);
         param3 = MathBase.limit(param3,0,PCT_MAX,false) / PCT_MAX;
         param4 = MathBase.limit(param4,0,PCT_MAX,false) / PCT_MAX;
         var _loc5_:Object = HSVtoRGB(param2,param3,param4);
         setColor(param1,hexFromPercentages(_loc5_));
      }
      
      public static function getHSVComponent(param1:DisplayObject, param2:uint = 0, param3:uint = 0) : Object
      {
         var _loc4_:Object = componentsFromHex(getColor(param1,param2,param3));
         _loc4_.r = _loc4_.r / 256;
         _loc4_.g = _loc4_.g / 256;
         _loc4_.b = _loc4_.b / 256;
         var _loc5_:Object = RGBtoHSV(_loc4_.r,_loc4_.g,_loc4_.b);
         _loc5_.h = Math.round(_loc5_.h);
         _loc5_.s = Math.round(_loc5_.s * PCT_MAX);
         _loc5_.v = Math.round(_loc5_.v * PCT_MAX);
         return _loc5_;
      }
      
      public static function componentsFromHex(param1:uint) : Object
      {
         var _loc2_:Number = param1 >> 16 & 255;
         var _loc3_:Number = param1 >> 8 & 255;
         var _loc4_:Number = param1 & 255;
         return {
            "r":_loc2_,
            "g":_loc3_,
            "b":_loc4_
         };
      }
      
      public static function hexFromPercentages(param1:Object) : uint
      {
         return hexFromComponents(param1.r * RGB_MAX,param1.g * RGB_MAX,param1.b * RGB_MAX);
      }
      
      public static function hexFromComponents(param1:uint, param2:uint, param3:uint) : uint
      {
         var _loc4_:uint = 0;
         _loc4_ = _loc4_ + (param1 << 16);
         _loc4_ = _loc4_ + (param2 << 8);
         _loc4_ = _loc4_ + param3;
         return _loc4_;
      }
      
      public static function getARGB(param1:uint) : Object
      {
         var _loc2_:Number = param1 >> 24 & 255;
         var _loc3_:Number = param1 >> 16 & 255;
         var _loc4_:Number = param1 >> 8 & 255;
         var _loc5_:Number = param1 & 255;
         return {
            "a":_loc2_,
            "r":_loc3_,
            "g":_loc4_,
            "b":_loc5_
         };
      }
      
      public static function setARGB(param1:Number, param2:Number, param3:Number, param4:Number) : uint
      {
         var _loc5_:uint = 0;
         _loc5_ = _loc5_ + (param1 << 24);
         _loc5_ = _loc5_ + (param2 << 16);
         _loc5_ = _loc5_ + (param3 << 8);
         _loc5_ = _loc5_ + param4;
         return _loc5_;
      }
      
      public static function toGrayscale(param1:uint) : uint
      {
         var _loc2_:Object = getARGB(param1);
         var _loc3_:Number = 0;
         _loc3_ = _loc3_ + _loc2_.r * 0.3;
         _loc3_ = _loc3_ + _loc2_.g * 0.59;
         _loc3_ = _loc3_ + _loc2_.b * 0.11;
         _loc2_.r = _loc2_.g = _loc2_.b = _loc3_;
         return setARGB(_loc2_.a,_loc2_.r,_loc2_.g,_loc2_.b);
      }
      
      public static function changeContrast(param1:Number, param2:Number) : Number
      {
         var _loc3_:Object = componentsFromHex(param1);
         _loc3_.r = MathBase.clamp(_loc3_.r + param2,0,255);
         _loc3_.g = MathBase.clamp(_loc3_.g + param2,0,255);
         _loc3_.b = MathBase.clamp(_loc3_.b + param2,0,255);
         return hexFromComponents(_loc3_.r,_loc3_.g,_loc3_.b);
      }
   }
}
