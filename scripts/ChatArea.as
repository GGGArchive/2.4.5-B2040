package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class ChatArea extends MovieClip
   {
       
      
      public var btn_chatenter:Btn_SendChat;
      
      public var bg_status:MovieClip;
      
      public var newStatus:MovieClip;
      
      public var btn_status:Btn_Notifications;
      
      public var mc_mask:MovieClip;
      
      public var input_BG:MovieClip;
      
      public var txt_chatmsg:TextField;
      
      public var mc_textholder:emptyMC;
      
      public var mc_chatslider:MovieClip;
      
      public function ChatArea()
      {
         super();
      }
   }
}
