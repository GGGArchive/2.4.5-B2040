package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   
   public class MafiaTipController
   {
      
      private static var _mafiaTipController:MafiaTipController;
       
      
      private var _isActive:Boolean = false;
      
      public function MafiaTipController()
      {
         super();
      }
      
      public static function getInstance() : MafiaTipController
      {
         if(!_mafiaTipController)
         {
            _mafiaTipController = new MafiaTipController();
         }
         return _mafiaTipController;
      }
      
      public function createTipPanel() : void
      {
         this.layoutManager.addTipPanel();
         this._isActive = true;
      }
      
      public function endTips() : void
      {
         this.layoutManager.removeTipPanel();
         this._isActive = false;
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      private function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
