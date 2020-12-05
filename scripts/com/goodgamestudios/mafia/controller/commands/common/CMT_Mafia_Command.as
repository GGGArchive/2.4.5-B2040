package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.commands.CMTCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.CommandController;
   
   public class CMT_Mafia_Command extends CMTCommand
   {
       
      
      public function CMT_Mafia_Command()
      {
         super();
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param1 == 0)
         {
            param2.shift();
            _loc3_ = String(param2.shift()).split("#");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = String(_loc3_[_loc4_]).split("+");
               _loc6_ = _loc5_.shift();
               _loc7_ = _loc5_.shift();
               if(TEASER_TYPE_TEXT_ID[_loc6_] != null)
               {
                  _loc8_ = BasicModel.languageData.getTextById(TEASER_TYPE_TEXT_ID[_loc6_],[BasicModel.userData.userName]);
                  _loc9_ = BasicModel.languageData.getTextById("cm_teaser" + _loc7_ + "_copy",[BasicModel.languageData.getTextById("gametitle")]);
                  CommandController.instance.executeCommand(BasicController.COMMAND_SHOW_COMA_TEASER,[_loc6_,_loc7_,_loc8_,_loc9_]);
                  trace("CMTCommand - known teaser type: " + _loc6_);
               }
               else
               {
                  trace("CMTCommand - unknown teaser type: " + _loc6_);
               }
               _loc4_++;
            }
         }
         return super.executeCommand(param1,param2);
      }
   }
}
