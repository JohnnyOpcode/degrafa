package com.degrafa.decorators
{
	import com.degrafa.geometry.command.*;

	public class CurveToLineDecorator implements IDrawDecorator
	{
		public function CurveToLineDecorator()
		{
			super();
		}
		
		public function execute(stack:CommandStack):void
		{
			var item:CommandStackItem;
			var cursor:CommandCursor = new CommandCursor(stack.cmdSource);
			
			while(cursor.moveNextCommand(CommandStackItem.CURVE_TO))
	   		{
	   			var dc:CommandStackItem = new CommandStackItem(CommandStackItem.DELEGATE_TO);
	   			dc.delegate = curveLineDelegate;
	   			cursor.insert(dc);
	   			cursor.moveNext();
        	}
		}
		
		public function curveLineDelegate(stack:CommandStack):void
		{
			var cursor:CommandCursor = new CommandCursor(stack.cmdSource);
			
			if(cursor.moveNextCommand(CommandStackItem.CURVE_TO))
   			{
   				cursor.current.type = CommandStackItem.LINE_TO;
   			}
		}
	}
}