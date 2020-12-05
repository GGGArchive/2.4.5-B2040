package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class MafiaSendFriendLinkCommand extends SimpleCommand
   {
       
      
      public function MafiaSendFriendLinkCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = param1 as Array;
         var _loc3_:String = _loc2_[0];
         var _loc4_:String = _loc2_[1];
         var _loc5_:String = _loc2_[2];
         var _loc6_:Array = new Array();
         _loc6_.push(_loc3_,_loc4_);
         if(_loc5_.length > 0)
         {
            _loc6_.push(_loc5_);
         }
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SEND_FRIEND_LINK,_loc6_);
      }
   }
}
