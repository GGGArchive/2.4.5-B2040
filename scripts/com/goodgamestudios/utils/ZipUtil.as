package com.goodgamestudios.utils
{
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class ZipUtil
   {
       
      
      public function ZipUtil()
      {
         super();
      }
      
      public static function tryUnzip(param1:ByteArray) : ByteArray
      {
         var result:ByteArray = null;
         var bytes:ByteArray = param1;
         try
         {
            result = unzip(bytes);
         }
         catch(e:IOError)
         {
            result = bytes;
         }
         catch(e:Error)
         {
            result = null;
         }
         finally
         {
            return result;
         }
      }
      
      public static function unzip(param1:ByteArray) : ByteArray
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:ByteArray = new ByteArray();
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.endian = Endian.LITTLE_ENDIAN;
         param1.position = 0;
         param1.readBytes(_loc7_,0,30);
         _loc5_ = 0;
         _loc7_.position = 26;
         _loc3_ = _loc7_.readUnsignedShort();
         _loc5_ = _loc5_ + _loc3_;
         _loc7_.position = 28;
         _loc4_ = _loc7_.readUnsignedShort();
         _loc5_ = _loc5_ + _loc4_;
         param1.readBytes(_loc7_,30,_loc5_);
         _loc7_.position = 18;
         _loc6_ = _loc7_.readUnsignedInt();
         _loc2_ = new ByteArray();
         param1.readBytes(_loc2_,0,_loc6_);
         _loc2_.inflate();
         return _loc2_;
      }
   }
}
