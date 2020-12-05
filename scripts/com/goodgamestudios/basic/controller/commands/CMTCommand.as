package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.CommandController;
   
   public class CMTCommand extends BasicCommand
   {
      
      public static const TEASERTYPE_EVENT:int = 0;
      
      public static const TEASERTYPE_INFO:int = 1;
      
      public static const TEASERTYPE_WARNING:int = 2;
      
      public static const TEASER_TYPE_TEXT_ID:Array = ["cm_teaserevent_title","cm_teaserinfo_title","cm_teaserwarning_title"];
       
      
      public function CMTCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_COMA_TEASER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(param1 == 0)
         {
            _loc3_ = com.adobe.serialization.json.JSON.decode(param2[1]);
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = _loc4_.type;
               _loc6_ = _loc4_.tid;
               if(TEASER_TYPE_TEXT_ID[_loc5_] != null)
               {
                  _loc7_ = BasicModel.languageData.getTextById(TEASER_TYPE_TEXT_ID[_loc5_],[BasicModel.userData.userName]);
                  _loc8_ = BasicModel.languageData.getTextById("cm_teaser" + _loc6_ + "_copy",[BasicModel.languageData.getTextById("gametitle")]);
                  CommandController.instance.executeCommand(BasicController.COMMAND_SHOW_COMA_TEASER,[_loc5_,_loc6_,_loc7_,_loc8_]);
               }
               else
               {
                  trace("CMTCommand - unknown teaser type: " + _loc5_);
               }
            }
         }
         return super.executeCommand(param1,param2);
      }
   }
}
