package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.model.components.BasicWodData;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.vo.BasicVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class MafiaWodData extends BasicWodData
   {
      
      private static const FORCE_EMBED_WORLD_VO_CLASSES:Array = [];
       
      
      protected var _voList:Dictionary;
      
      public function MafiaWodData(param1:XML)
      {
         this._voList = new Dictionary();
         super(param1);
         this.parseVOFromWODXml();
      }
      
      private function parseVOFromWODXml() : void
      {
         var wodElement:XML = null;
         var wodId:int = 0;
         var name:String = null;
         var group:String = null;
         var type:String = null;
         var voClass:Class = null;
         var voObject:BasicVO = null;
         var xmlWodList:XMLList = wodXML.elements();
         for each(wodElement in xmlWodList)
         {
            wodId = parseInt(wodElement.attribute("id"));
            name = wodElement.attribute("n");
            group = wodElement.attribute("g");
            type = wodElement.attribute("t");
            try
            {
               voClass = getDefinitionByName(Constants_Basic.MAFIA_VO_CLASS_PATH + group.toLowerCase() + "::" + name + group + "VO") as Class;
               voObject = new voClass();
               voObject.fillFromParamXML(wodElement);
               this._voList[wodId] = voObject;
            }
            catch(error:Error)
            {
               trace("ERROR: Class does not exists - " + group.toLowerCase() + "::" + name + group + "VO");
               continue;
            }
         }
      }
      
      public function getItemVObyID(param1:int) : ItemVO
      {
         return this._voList[param1];
      }
      
      public function get voList() : Dictionary
      {
         return this._voList;
      }
   }
}
