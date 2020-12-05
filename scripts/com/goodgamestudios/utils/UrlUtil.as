package com.goodgamestudios.utils
{
   public class UrlUtil
   {
       
      
      public function UrlUtil()
      {
         super();
      }
      
      public static function getCleanReferrer(param1:String) : String
      {
         return getProtocol(param1) + "://" + getServerName(param1);
      }
      
      public static function getServerNameWithPort(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("/") + 2;
         var _loc3_:int = param1.indexOf("/",_loc2_);
         return _loc3_ == -1?param1.substring(_loc2_):param1.substring(_loc2_,_loc3_);
      }
      
      public static function getServerName(param1:String) : String
      {
         var _loc2_:String = getServerNameWithPort(param1);
         var _loc3_:int = _loc2_.indexOf("]");
         _loc3_ = _loc3_ > -1?int(_loc2_.indexOf(":",_loc3_)):int(_loc2_.indexOf(":"));
         if(_loc3_ > 0)
         {
            _loc2_ = _loc2_.substring(0,_loc3_);
         }
         return _loc2_;
      }
      
      public static function getProtocol(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("/");
         var _loc3_:int = param1.indexOf(":/");
         if(_loc3_ > -1 && _loc3_ < _loc2_)
         {
            return param1.substring(0,_loc3_);
         }
         _loc3_ = param1.indexOf("::");
         if(_loc3_ > -1 && _loc3_ < _loc2_)
         {
            return param1.substring(0,_loc3_);
         }
         return "";
      }
   }
}
