/**
 * class SVGRenderer < Renderer
 *
 * Physics.renderer('svg')
 *
 * Renderer that manipulates SVG elements according to the physics simulation. Very primative...
 **/
Physics.renderer('svg', function(proto) {

  if (!document) {
    // must be in node environment
    return {};
  }
  var px = 'px';
  var classpfx = 'pjs-';
  var newElement = function(node, content) {
    var el = document.createElement(node || 'svg');
    if (content) {
      el.innerHTML = content;
    }
    return el;
  };
  var drawBody;

  return {
    // extended
    init: function(options) {

      // call proto init
      proto.init.call(this, options);

      var viewport = this.el;
      viewport.transform = 'translateZ(0)'; // force GPU accel
      viewport.width = this.options.width + px;
      viewport.height = this.options.height + px;

      this.els = {};

      if (options.meta) {
        var stats = newElement();
        stats.className = classpfx + 'meta';
        this.els.fps = newElement('span');
        this.els.ipf = newElement('span');
        stats.appendChild(newElement('span', 'fps: '));
        stats.appendChild(this.els.fps);
        stats.appendChild(newElement('br'));
        stats.appendChild(newElement('span', 'ipf: '));
        stats.appendChild(this.els.ipf);

        viewport.appendChild(stats);
      }

      if (this.options.autoResize) {
        this.resize();
      } else {
        this.resize(this.options.width, this.options.height);
      }
    },

    // extended
    resize: function(width, height) {
      proto.resize.call(this, width, height);
      this.el.width = this.width + px;
      this.el.height = this.height + px;
    },

    /** internal
     * SVGRenderer#pointProperties( el, geometry )
     * - el (HTMLElement): The element
     * - geometry (Geometry): The body's geometry
     *
     * Set dom element style properties for a point.
     **/
    pointProperties: function(el, geometry) {
      el.width = '2px';
      el.height = '2px';
      el.style.marginLeft = '-1px';
      el.style.marginTop = '-1px';
      el.rx = '50';
      el.ry = '50';
    },

    /** internal
     * SVGRenderer#circleProperties( el, geometry )
     * - el (HTMLElement): The element
     * - geometry (Geometry): The body's geometry
     *
     * Set dom element style properties for a circle.
     **/
    circleProperties: function(el, geometry) {

      var aabb = geometry.aabb();

      el.width = (aabb.hw * 2) + px;
      el.height = (aabb.hh * 2) + px;
      el.style.marginLeft = (-aabb.hw) + px;
      el.style.marginTop = (-aabb.hh) + px;
      el.rx = '50';
      el.ry = '50';
    },

    /** internal
     * SVGRenderer#rectangleProperties( el, geometry )
     * - el (HTMLElement): The element
     * - geometry (Geometry): The body's geometry
     *
     * Set dom element style properties for a rectangle.
     **/
    rectangleProperties: function(el, geometry) {

      var aabb = geometry.aabb();

      el.width = (aabb.hw * 2) + px;
      el.height = (aabb.hh * 2) + px;
      el.style.marginLeft = (-aabb.hw) + px;
      el.style.marginTop = (-aabb.hh) + px;
    },

    // extended
    createView: function(geometry) {

      var el = newElement(),
        chel, fn = geometry.name + 'Properties';

      el.className = classpfx + geometry.name;
      el.y = '0';
      el.x = '0';

      if (geometry.name === 'compound') {

        for (var i = 0, l = geometry.children.length, ch; i < l; i++) {
          ch = geometry.children[i];
          chel = newElement();
          chel.className = classpfx + geometry.name + ' ' + classpfx + 'child';
          chel.y = '0';
          chel.x = '0';
          if (this[ch.g.name + 'Properties']) {
            this[ch.g.name + 'Properties'](chel, ch.g);
          }
          chel.transform = 'translate(' + ch.pos._[0] + 'px,' + ch.pos._[1] + 'px) rotate(' + ch.angle + 'rad)';
          el.appendChild(chel);
        }

      } else if (this[fn]) {
        this[fn](el, geometry);
      }

      this.el.appendChild(el);
      return el;
    },

    // extended
    connect: function(world) {

      world.on('add:body', this.attach, this);
      world.on('remove:body', this.detach, this);
    },

    // extended
    disconnect: function(world) {

      world.off('add:body', this.attach, this);
      world.off('remove:body', this.detach, this);
    },

    /**
     * SVGRenderer#detach( data ) -> this
     * - data (HTMLElement|Object): DOM node or event data (`data.body`)
     *
     * Event callback to detach a node from the DOM
     **/
    detach: function(data) {

      // interpred data as either dom node or event data
      var el = (data.nodeType && data) || (data.body && data.body.view),
        par = el && el.parentNode;

      if (el && par) {
        // remove view from dom
        par.removeChild(el);
      }

      return this;
    },

    /**
     * SVGRenderer#attach( data ) -> this
     * - data (HTMLElement|Object): DOM node or event data (`data.body`)
     *
     * Event callback to attach a node to the viewport
     **/
    attach: function(data) {

      // interpred data as either dom node or event data
      var el = (data.nodeType && data) || (data.body && data.body.view);

      if (el) {
        // attach to viewport
        this.el.appendChild(el);
      }

      return this;
    },

    // extended
    drawMeta: function(meta) {

      this.els.fps.innerHTML = meta.fps.toFixed(2);
      this.els.ipf.innerHTML = meta.ipf;
    },

    // extended
    drawBody: function(body, view) {

      var pos = body.state.pos,
        v = body.state.vel,
        os = body.offset,
        x, y, ang, t = this._interpolateTime;

      // interpolate positions
      x = pos._[0] + v._[0] * t;
      y = pos._[1] + v._[1] * t;
      ang = body.state.angular.pos + body.state.angular.vel * t;
      view.transform = 'translate(' + x + 'px,' + y + 'px) rotate(' + ang + 'rad) translate(' + os._[0] + 'px,' + os._[1] + 'px)';
    }
  };
});
