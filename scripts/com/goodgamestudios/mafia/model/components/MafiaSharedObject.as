package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicSharedObject;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   
   public class MafiaSharedObject extends BasicSharedObject
   {
       
      
      public function MafiaSharedObject()
      {
         super();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      public function readDungeonMapId() : int
      {
         if(so.data.dungeonMapId)
         {
            return so.data.dungeonMapId as int;
         }
         return 1;
      }
      
      public function saveDungeonMapId(param1:int) : void
      {
         so.data.dungeonMapId = param1;
         writeData();
      }
      
      override public function saveLoginData(param1:String, param2:String, param3:Boolean) : void
      {
         so.data["username_" + readInstanceId()] = param1;
         so.data["pass_" + readInstanceId()] = encrypt(param2);
         if(param1 == "")
         {
            so.data.user = "";
            so.data.password = encrypt("");
         }
         so.data.save = param3.toString();
         so.data.encryptPass = "true";
         writeData();
      }
      
      public function readCurrentTopInventoryRow() : int
      {
         if(so.data["topInventoryRow_" + readInstanceId()])
         {
            return so.data["topInventoryRow_" + readInstanceId()] as int;
         }
         return 0;
      }
      
      public function saveCurrentTopInventoryRow(param1:int) : void
      {
         so.data["topInventoryRow_" + readInstanceId()] = param1;
         writeData();
      }
   }
}
