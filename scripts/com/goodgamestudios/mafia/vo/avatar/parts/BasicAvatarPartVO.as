package com.goodgamestudios.mafia.vo.avatar.parts
{
   public class BasicAvatarPartVO
   {
       
      
      private var _wodID:int;
      
      public function BasicAvatarPartVO()
      {
         super();
      }
      
      public function get wodID() : int
      {
         return this._wodID;
      }
      
      public function set wodID(param1:int) : void
      {
         this._wodID = param1;
      }
   }
}
