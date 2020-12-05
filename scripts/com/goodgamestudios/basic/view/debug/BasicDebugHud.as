package com.goodgamestudios.basic.view.debug
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuBuiltInItems;
   import flash.ui.ContextMenuItem;
   
   public class BasicDebugHud
   {
      
      private static const CONTEXT_INFO_TEXT_PREFIX:String = "Running in [ ";
      
      private static const CONTEXT_INFO_TEXT_POSTFIX:String = " ] Mode";
      
      private static const DEBUG_MODE_CONTEXT_INFO_TEXT:String = "DEBUG";
      
      private static const TEST_MODE_CONTEXT_INFO_TEXT:String = "Test";
      
      private static const DEBUG_SQUARE_SIZE:Number = 4;
      
      private static const DEBUG_SQUARE_HORIZONTAL_GAP:Number = 4;
      
      private static var _contextMenu:ContextMenu;
      
      private static var _xpos:int;
      
      private static var _target:DisplayObjectContainer;
       
      
      public function BasicDebugHud()
      {
         super();
      }
      
      public static function showDebugInformationHud(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Sprite = new Sprite();
         param1.addChild(_loc2_);
         _target = _loc2_;
         _contextMenu = new ContextMenu();
         removeDefaultItems();
         _xpos = 0;
         displayTestModeViaFlashvarsInfo();
         displayDebugModeInfo();
         _target.contextMenu = _contextMenu;
      }
      
      private static function removeDefaultItems() : void
      {
         _contextMenu.hideBuiltInItems();
         var _loc1_:ContextMenuBuiltInItems = _contextMenu.builtInItems;
         _loc1_.print = true;
      }
      
      private static function displayDebugModeInfo() : void
      {
      }
      
      private static function displayTestModeViaFlashvarsInfo() : void
      {
         var _loc1_:Shape = null;
         var _loc2_:String = null;
         var _loc3_:ContextMenuItem = null;
         if(_target.root.loaderInfo.parameters.test == "on")
         {
            _loc1_ = new Shape();
            _loc1_.graphics.beginFill(15649024);
            _loc1_.graphics.drawRect(_xpos,0,DEBUG_SQUARE_SIZE,DEBUG_SQUARE_SIZE);
            _target.addChild(_loc1_);
            _xpos = _xpos + DEBUG_SQUARE_HORIZONTAL_GAP;
            _loc2_ = CONTEXT_INFO_TEXT_PREFIX + DEBUG_MODE_CONTEXT_INFO_TEXT + CONTEXT_INFO_TEXT_POSTFIX;
            _loc3_ = new ContextMenuItem(_loc2_,true);
            _contextMenu.customItems.push(_loc3_);
         }
      }
   }
}
