package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   
   public class MafiaUnlockedAssetsData
   {
      
      public static const KANI_WEST_GLASSES:int = 16590;
       
      
      private var assetIds:Array;
      
      public var specialAvatarPartsBackgrounds:Array;
      
      public var specialAvatarPartsBeards:Array;
      
      public var specialAvatarPartsJaws:Array;
      
      public var specialAvatarPartsBodies:Array;
      
      public var specialAvatarPartsExtrasUnder:Array;
      
      public var specialAvatarPartsExtrasTop:Array;
      
      public var specialAvatarPartsMouths:Array;
      
      public var specialAvatarPartsNoses:Array;
      
      public var specialAvatarPartsEyes:Array;
      
      public var specialAvatarPartsEyebrows:Array;
      
      public var specialAvatarPartsBackhairs:Array;
      
      public var specialAvatarPartsFronthairs:Array;
      
      public function MafiaUnlockedAssetsData()
      {
         super();
         this.assetIds = new Array();
      }
      
      public function parseUnlockedAssets(param1:String) : void
      {
         var _loc2_:int = 0;
         this.assetIds = param1.split("#");
         this.specialAvatarPartsBackgrounds = new Array();
         this.specialAvatarPartsBeards = new Array();
         this.specialAvatarPartsJaws = new Array();
         this.specialAvatarPartsBodies = new Array();
         this.specialAvatarPartsExtrasUnder = new Array();
         this.specialAvatarPartsExtrasTop = new Array();
         this.specialAvatarPartsMouths = new Array();
         this.specialAvatarPartsNoses = new Array();
         this.specialAvatarPartsEyes = new Array();
         this.specialAvatarPartsEyebrows = new Array();
         this.specialAvatarPartsBackhairs = new Array();
         this.specialAvatarPartsFronthairs = new Array();
         for each(_loc2_ in this.assetIds)
         {
            if(_loc2_ > 0)
            {
               if(_loc2_ >= Constants_Avatarparts.BACKGROUND_STARTWODID)
               {
                  this.specialAvatarPartsBackgrounds.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.MALE_BEARD_STARTWODID)
               {
                  this.specialAvatarPartsBeards.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_JAW_STARTWODID)
               {
                  this.specialAvatarPartsJaws.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_BODY_STARTWODID)
               {
                  this.specialAvatarPartsBodies.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_EXTRASUNDER_STARTWODID)
               {
                  this.specialAvatarPartsExtrasUnder.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_EXTRASTOP_STARTWODID)
               {
                  this.specialAvatarPartsExtrasTop.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_MOUTHS_STARTWODID)
               {
                  this.specialAvatarPartsMouths.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_NOSES_STARTWODID)
               {
                  this.specialAvatarPartsNoses.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_EYES_STARTWODID)
               {
                  this.specialAvatarPartsEyes.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_EYEBROWS_STARTWODID)
               {
                  this.specialAvatarPartsEyebrows.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_BACKHAIR_STARTWODID)
               {
                  this.specialAvatarPartsBackhairs.push(_loc2_);
               }
               else if(_loc2_ >= Constants_Avatarparts.FEMALE_FRONTHAIR_STARTWODID)
               {
                  this.specialAvatarPartsFronthairs.push(_loc2_);
               }
               else
               {
                  trace("CAN\'T FIND VALIDE AVATARPARTLIST");
               }
            }
         }
      }
   }
}
