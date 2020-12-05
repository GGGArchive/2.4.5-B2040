package com.goodgamestudios.mafia.constants.enums
{
   public class MessageType extends BasicEnum
   {
      
      private static var _fightWon:MessageType;
      
      private static var _fightLost:MessageType;
      
      private static var _clanInvitation:MessageType;
      
      private static var _newsletter:MessageType;
      
      private static var _clanKick:MessageType;
      
      private static var _admin:MessageType;
      
      private static var _playerMessage:MessageType;
      
      private static var _paymentDoppler:MessageType;
       
      
      public function MessageType(param1:String, param2:uint, param3:DoNotInstantiate#86)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get FightWon() : MessageType
      {
         if(_fightWon == null)
         {
            _fightWon = new MessageType("FightWon",1,new DoNotInstantiate#86());
         }
         return _fightWon;
      }
      
      public static function get FightLost() : MessageType
      {
         if(_fightLost == null)
         {
            _fightLost = new MessageType("FightLost",2,new DoNotInstantiate#86());
         }
         return _fightLost;
      }
      
      public static function get ClanInvitation() : MessageType
      {
         if(_clanInvitation == null)
         {
            _clanInvitation = new MessageType("ClanInvitation",3,new DoNotInstantiate#86());
         }
         return _clanInvitation;
      }
      
      public static function get Newsletter() : MessageType
      {
         if(_newsletter == null)
         {
            _newsletter = new MessageType("Newsletter",4,new DoNotInstantiate#86());
         }
         return _newsletter;
      }
      
      public static function get ClanKick() : MessageType
      {
         if(_clanKick == null)
         {
            _clanKick = new MessageType("ClanKick",5,new DoNotInstantiate#86());
         }
         return _clanKick;
      }
      
      public static function get Admin() : MessageType
      {
         if(_admin == null)
         {
            _admin = new MessageType("Admin",6,new DoNotInstantiate#86());
         }
         return _admin;
      }
      
      public static function get PlayerMessage() : MessageType
      {
         if(_playerMessage == null)
         {
            _playerMessage = new MessageType("PlayerMessage",7,new DoNotInstantiate#86());
         }
         return _playerMessage;
      }
      
      public static function get PaymentDoppler() : MessageType
      {
         if(_paymentDoppler == null)
         {
            _paymentDoppler = new MessageType("PaymentDoppler",8,new DoNotInstantiate#86());
         }
         return _paymentDoppler;
      }
   }
}

class DoNotInstantiate#86
{
    
   
   function DoNotInstantiate#86()
   {
      super();
   }
}
