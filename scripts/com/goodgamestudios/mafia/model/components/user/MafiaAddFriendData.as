package com.goodgamestudios.mafia.model.components.user
{
   public class MafiaAddFriendData
   {
       
      
      private var _invitedToInstance:int = 0;
      
      private var _invitentionHashCode:String = "";
      
      public function MafiaAddFriendData()
      {
         super();
      }
      
      public function get invitationToInstance() : int
      {
         return this._invitedToInstance;
      }
      
      public function set invitationToInstance(param1:int) : void
      {
         this._invitedToInstance = param1;
      }
      
      public function get invitationHashCode() : String
      {
         return this._invitentionHashCode;
      }
      
      public function set invitationHashCode(param1:String) : void
      {
         this._invitentionHashCode = param1;
      }
      
      public function get isValid() : Boolean
      {
         return this.invitationHashCode != null && this.invitationHashCode != "";
      }
   }
}
