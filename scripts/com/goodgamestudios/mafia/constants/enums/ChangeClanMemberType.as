package com.goodgamestudios.mafia.constants.enums
{
   public class ChangeClanMemberType extends BasicEnum
   {
      
      private static var _kick:ChangeClanMemberType;
      
      private static var _leader:ChangeClanMemberType;
      
      private static var _assistant:ChangeClanMemberType;
      
      private static var _officer:ChangeClanMemberType;
      
      private static var _normal:ChangeClanMemberType;
       
      
      public function ChangeClanMemberType(param1:String, param2:uint, param3:DoNotInstantiate#69)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get leader() : ChangeClanMemberType
      {
         if(_leader == null)
         {
            _leader = new ChangeClanMemberType("Leader",0,new DoNotInstantiate#69());
         }
         return _leader;
      }
      
      public static function get assistant() : ChangeClanMemberType
      {
         if(_assistant == null)
         {
            _assistant = new ChangeClanMemberType("Assistant",1,new DoNotInstantiate#69());
         }
         return _assistant;
      }
      
      public static function get officer() : ChangeClanMemberType
      {
         if(_officer == null)
         {
            _officer = new ChangeClanMemberType("Officer",2,new DoNotInstantiate#69());
         }
         return _officer;
      }
      
      public static function get normal() : ChangeClanMemberType
      {
         if(_normal == null)
         {
            _normal = new ChangeClanMemberType("Normal",3,new DoNotInstantiate#69());
         }
         return _normal;
      }
      
      public static function get kick() : ChangeClanMemberType
      {
         if(_kick == null)
         {
            _kick = new ChangeClanMemberType("Kick",4,new DoNotInstantiate#69());
         }
         return _kick;
      }
   }
}

class DoNotInstantiate#69
{
    
   
   function DoNotInstantiate#69()
   {
      super();
   }
}
