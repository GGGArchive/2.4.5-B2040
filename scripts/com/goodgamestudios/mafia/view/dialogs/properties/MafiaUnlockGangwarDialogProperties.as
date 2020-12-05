package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   
   public class MafiaUnlockGangwarDialogProperties extends BasicProperties
   {
       
      
      public var dungeon:GangwarVO;
      
      public var addFriendDialog:Boolean;
      
      public var functionYes:Function;
      
      public function MafiaUnlockGangwarDialogProperties(param1:GangwarVO, param2:Function = null)
      {
         this.dungeon = param1;
         this.addFriendDialog = this.addFriendDialog;
         this.functionYes = param2;
         super();
      }
   }
}
