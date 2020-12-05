package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.CommandController;
   
   public class NFOCommand extends BasicCommand
   {
       
      
      public function NFOCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_SERVER_INFO_EVENT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Object = null;
         switch(param1)
         {
            case BasicSmartfoxConstants.ERROR_OK:
               _loc3_ = com.adobe.serialization.json.JSON.decode(param2.pop());
               BasicModel.basicLocalization.setUsernameMinLength = _loc3_.minNameSize;
               BasicModel.basicLocalization.setUsernameMinLengthByCountry();
               CommandController.instance.executeCommand(BasicController.COMMAND_JOINED_ROOM);
         }
         return true;
      }
   }
}
