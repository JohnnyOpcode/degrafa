////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2008 Jason Hawryluk, Juan Sanchez, Andy McIntosh, Ben Stucki 
// Pavan Podila , Sean Chatman, Greg Dove, Thomas Gonzalez and Maikel Sibbald.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////
package com.degrafa.geometry{
	
	import com.degrafa.IGeometry;
	import com.degrafa.geometry.utilities.GeometryUtils;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.net.registerClassAlias;
	
	//--------------------------------------
	//  Other metadata
	//--------------------------------------
	
	[IconFile("QuadraticBezier.png")]

	[Bindable]	
	/**
 	*  The QuadraticBezier element draws a quadratic Bézier using the specified 
 	 * start point, end point and control point.
 	*  
 	*  @see http://degrafa.com/samples/QuadraticBezier_Element.html
 	*  
 	**/	
	public class QuadraticBezier extends Geometry implements IGeometry{
		
		/**
	 	* Constructor.
	 	*  
	 	* <p>The quadratic Bézier constructor accepts 6 optional arguments that define it's 
	 	* start, end and controls points.</p>
	 	* 
	 	* @param x A number indicating the starting x-axis coordinate.
	 	* @param y A number indicating the starting y-axis coordinate.
	 	* @param cx A number indicating the control x-axis coordinate. 
	 	* @param cy A number indicating the control y-axis coordinate.
	 	* @param x1 A number indicating the ending x-axis coordinate.
	 	* @param y1 A number indicating the ending y-axis coordinate. 
	 	*/		
		public function QuadraticBezier(x:Number=NaN,y:Number=NaN,cx:Number=NaN,cy:Number=NaN,x1:Number=NaN,y1:Number=NaN){
			super();
			
			this.x=x;
			this.y=y;
			this.cx=cx;
			this.cy=cy;
			this.x1=x1;
			this.y1=y1;
			
			registerClassAlias("com.degrafa.geometry.QuadraticBezier", QuadraticBezier);
			
		}
		
		/**
		* QuadraticBezier short hand data value.
		* 
		* <p>The quadratic Bézier data property expects exactly 6 values x, 
		*  y, cx, cy, x1 and y1 separated by spaces.</p>
		* 
		* @see Geometry#data
		* 
		**/
		override public function set data(value:String):void{
			
			if(super.data != value){
				super.data = value;
				
				//parse the string on the space
				var tempArray:Array = value.split(" ");
				
				if (tempArray.length == 6){
					_x=tempArray[0];
					_y=tempArray[1];
					_cx=tempArray[2];
					_cy=tempArray[3];
					_x1=tempArray[4];
					_y1=tempArray[5];
				}	
				
				invalidated = true;
				
			}
		} 
		
		private var _x:Number;
		/**
		* The x-coordinate of the start point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get x():Number{
			if(!_x){return 0;}
			return _x;
		}
		public function set x(value:Number):void{
			if(_x != value){
				_x = value;
				invalidated = true;
			}
		}
		
		
		private var _y:Number;
		/**
		* The y-coordinate of the start point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get y():Number{
			if(!_y){return 0;}
			return _y;
		}
		public function set y(value:Number):void{
			if(_y != value){
				_y = value;
				invalidated = true;
			}
		}
		
		
		private var _x1:Number;
		/**
		* The x-coordinate of the end point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get x1():Number{
			if(!_x1){return 0;}
			return _x1;
		}
		public function set x1(value:Number):void{
			if(_x1 != value){
				_x1 = value;
				invalidated = true;
			}
		}
		
		
		private var _y1:Number;
		/**
		* The y-coordinate of the end point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get y1():Number{
			if(!_y1){return 0;}
			return _y1;
		}
		public function set y1(value:Number):void{
			if(_y1 != value){
				_y1 = value;
				invalidated = true;
			}
		}
		
		
		private var _cx:Number;
		/**
		* The x-coordinate of the control point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get cx():Number{
			if(!_cx){return 0;}
			return _cx;
		}
		public function set cx(value:Number):void{
			if(_cx != value){
				_cx = value;
				invalidated = true;
			}
		}
		
		
		private var _cy:Number;
		/**
		* The y-coordinate of the control point of the curve. If not specified 
		* a default value of 0 is used.
		**/
		public function get cy():Number{
			if(!_cy){return 0;}
			return _cy;
		}
		public function set cy(value:Number):void{
			if(_cy != value){
				_cy = value;
				invalidated = true;
			}
		}
		
		private var _bounds:Rectangle;
		/**
		* The tight bounds of this element as represented by a Rectangle object. 
		**/
		override public function get bounds():Rectangle{
			return _bounds;	
		}
		
		/**
		* Calculates the bounds for this element. 
		**/		
		private function calcBounds():void{
			_bounds = GeometryUtils.bezierBounds(x,y,cx,cy,x1,y1);
		}
		
		/**
		* @inheritDoc 
		**/
		override public function preDraw():void{
			if(invalidated){
			
				commandStack.length=0;
				
				commandStack.addMoveTo(x,y);
				commandStack.addCurveTo(cx,cy,x1,y1);
			
				calcBounds();
				invalidated = false;
			}
			
		}
				
		/**
		* Begins the draw phase for geometry objects. All geometry objects 
		* override this to do their specific rendering.
		* 
		* @param graphics The current context to draw to.
		* @param rc A Rectangle object used for fill bounds. 
		**/								
		override public function draw(graphics:Graphics,rc:Rectangle):void{				
			//re init if required
		 	preDraw();
			super.draw(graphics,(rc)? rc:_bounds);
		}
		
		/**
		* An object to derive this objects properties from. When specified this 
		* object will derive it's unspecified properties from the passed object.
		**/
		public function set derive(value:QuadraticBezier):void{
			
			if (!fill){fill=value.fill;}
			if (!stroke){stroke = value.stroke}
			if (!_x){_x = value.x;}
			if (!_y){_y = value.y;}
			if (!_cx){_cx = value.cx;}
			if (!_cy){_cy = value.cy;}
			if (!_x1){_x1 = value.x1;}
			if (!_y1){_y1 = value.y1;}
			
			
		}
		
	}
}