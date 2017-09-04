Read this file if you are going to modify stats.xslt.

The 2 variables defined at the top are the expand/collapse arrows.

The javascript section has functions to initialize tabs, 
get an absolute path, toggle layers, switch between expand and collapse
images, expand all layers (for a given tab), and collapse all layers  
(for a given tab). toggleImage() uses the variables for the expand and
collapse images defined at the top of the file, using xslt to select
the values. Layers are hidden by changing the value of the display
attribute of a div from 'block' to 'none'. Note that ampersands must be
written as &amp; because there is no CDATA tag around this section.

The next section is CSS for divs that are toggled. They define whether
the div is initially visible or not visible.

The next section is the xslt/html.
Notes about this section:
-Each toggleable div has a corresponding image called [divname]_img.
-Templates are defined at the bottom. Templates match on the XML tag.
-In general, sections that use templates are the ones with recursive tables.

Templates:
-stat template: the first iteration of the template assumes that a table has
already been constructed and there is a line of headings. The template inserts
the values for name, count, average,standard deviation, min, max, and total 
(in that order). If there are more stats elements, a table within the table 
is created. The heading line is constructed and the template is called 
again. This table is toggleable.


The Endeca coloring was done by modifying the Yahoo CSS.
