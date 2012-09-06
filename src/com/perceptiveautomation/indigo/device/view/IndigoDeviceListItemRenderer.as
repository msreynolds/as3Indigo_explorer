/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/18/12
 * Time: 11:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.device.view
{
    import com.mtnlabs.graphics.MountainLabsGraphics;
    import com.perceptiveautomation.indigo.device.IIndigoDevice;
    import com.perceptiveautomation.indigo.device.IIndigoDimmerDevice;
    import com.perceptiveautomation.indigo.device.IIndigoDimmerDevice;
    import com.perceptiveautomation.indigo.device.IIndigoOnOffDevice;
    import com.perceptiveautomation.indigo.device.IIndigoOnOffDevice;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import spark.components.Label;
    import spark.components.NumericStepper;
    import spark.components.supportClasses.ItemRenderer;
    import spark.events.ListEvent;
    import spark.primitives.BitmapImage;

    public class IndigoDeviceListItemRenderer extends ItemRenderer
    {

        private var _indigoDevice:IIndigoDevice;

        // Child Display Objects
        private var _bitmapDeviceStatus:BitmapImage;
        private var _bitmapUp:BitmapImage;
        private var _bitmapDown:BitmapImage;
        private var _labelDeviceName:Label;

        public function IndigoDeviceListItemRenderer()
        {
            this.height = 28;
            this.doubleClickEnabled = true;
            this.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseDoubleClick);
        }

        override public function set data(value:Object):void
        {
            if (_indigoDevice !== null)
            {
                removeDeviceListeners();
            }

            super.data = value;

            if (value is IIndigoDevice)
            {
                _indigoDevice = value as IIndigoDevice;
                updateRendererView();
                addDeviceListeners();
            }
        }

        override protected function createChildren():void
        {
            super.createChildren();

            if (!_bitmapDeviceStatus)
            {
                _bitmapDeviceStatus = new BitmapImage();
                _bitmapDeviceStatus.source = MountainLabsGraphics.iconBulletRed;
                _bitmapDeviceStatus.left = 3;
                _bitmapDeviceStatus.top = 6;
                _bitmapDeviceStatus.addEventListener(MouseEvent.CLICK, toggle);
                this.addElement( _bitmapDeviceStatus );
            }

            if (!_bitmapUp)
            {
                _bitmapUp = new BitmapImage();
                _bitmapUp.source = MountainLabsGraphics.iconBulletArrowUp;
                _bitmapUp.left = 18;
                _bitmapUp.top = 1;
                _bitmapUp.addEventListener(MouseEvent.CLICK, brighten);
                this.addElement( _bitmapUp );
            }

            if (!_bitmapDown)
            {
                _bitmapDown = new BitmapImage();
                _bitmapDown.source = MountainLabsGraphics.iconBulletArrowDown;
                _bitmapDown.left = 18;
                _bitmapDown.bottom = 1;
                _bitmapDown.addEventListener(MouseEvent.CLICK, dim);
                this.addElement( _bitmapDown );
            }

            if (!_labelDeviceName)
            {
                _labelDeviceName = new Label();
                _labelDeviceName.text = (_indigoDevice !== null) ?_indigoDevice.name : "Name Not Available";
                _labelDeviceName.left = 36;
                _labelDeviceName.top = 9;
                this.addElement( _labelDeviceName );
            }
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            updateRendererView();
        }

        override protected function updateDisplayList(unscaledWidth:Number,  unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (_indigoDevice is IIndigoDimmerDevice)
            {
                _bitmapUp.alpha = 1;
                _bitmapDown.alpha = 1;
            }
            else
            {
                _bitmapUp.alpha = 0.15;
                _bitmapDown.alpha = 0.15;
            }
        }

        protected function addDeviceListeners():void
        {
            _indigoDevice.addEventListener("isOnChanged", handleDevicePropertyChangeEvent);
            _indigoDevice.addEventListener("brightnessChanged", handleDevicePropertyChangeEvent);
        }

        protected function removeDeviceListeners():void
        {
            _indigoDevice.removeEventListener("isOnChanged", handleDevicePropertyChangeEvent);
            _indigoDevice.removeEventListener("brightnessChanged", handleDevicePropertyChangeEvent);
        }

        protected function handleDevicePropertyChangeEvent(event:Event):void
        {
            updateRendererView();
        }

        protected function handleMouseDoubleClick(event:MouseEvent):void
        {
            var listEvent:ListEvent = new ListEvent("showItemDetail",false,false,NaN,NaN,null,false,false,false,false,0,-1,this.data, this);
            this.owner.dispatchEvent(listEvent);
        }

        protected function updateRendererView():void
        {
            if (_indigoDevice !== null)
            {
                _labelDeviceName.text = (_indigoDevice.name == "") ? "Name Not Available" : _indigoDevice.name;

                if (_indigoDevice is IIndigoOnOffDevice)
                {
                    _bitmapDeviceStatus.source = (IIndigoOnOffDevice(_indigoDevice).isOn) ? MountainLabsGraphics.iconBulletGreen : MountainLabsGraphics.iconBulletRed;
                }

                if (_indigoDevice is IIndigoDimmerDevice)
                {
                    this.toolTip = IIndigoDimmerDevice(_indigoDevice).brightness.toString();
                }
            }
        }

        public function dim(event:Event):void
        {
            IIndigoDimmerDevice(_indigoDevice).brightness -= 1;
        }

        public function brighten(event:Event):void
        {
            IIndigoDimmerDevice(_indigoDevice).brightness += 1;
        }

        public function toggle(event:Event):void
        {
            IIndigoOnOffDevice(_indigoDevice).isOn ? IIndigoOnOffDevice(_indigoDevice).turnOff() : IIndigoOnOffDevice(_indigoDevice).turnOn();
        }
    }
}
