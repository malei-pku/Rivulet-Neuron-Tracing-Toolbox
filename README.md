# Rivulet-Neuron-Tracing-Toobox

Rivulet logo ![Build Status](https://github.com/lsqshr/Rivulet-Neuron-Tracing-Toolbox/blob/master/Rivulet_resources/icon_48.png)
=============================
Rivulet Neuron Reconstruction 
=============================

Background
==========

Brief theoretical description
=============================

Examples
========
The gif below show the animation of tracing process. 

**Red Sphere** : represents the startig point of each rivulet back tracing. 
As you may already notice, most of rivulet tracing starts from the axon terminal or the dendrites termini of
neuron.

**Blue Line** : represents the traced path of neuron.

**Red Line** : represents the swc structure ignoring the radius. We ignored radius deliberately to reveal the all potential
miswiring connections.

**Soma check box under Tracing Parameters Panel** : Untick it if you do not have soma in this image. If you have soma in this image, you should do soma detection first. Although you can choose to do neuron reconstruction directly without soma detection, it is not recommended.

**Plot check box under Tracing Parameters Panel** : Basically, click it means you want to visualise the tracing process. You just want to get swc as soon as possible, you should consider untick it.

**Washaway check box** : You've got to crack a few eggs to make an omelette. There is no free lunch in comuter vision area. This button increases the tracing process dramatically, but you have suffer some loss of detailed dendrites reconstructions.

**Trace button** : Press it, Rivulet start to trace. It is that simple. Believe it or not?

**Threshold slider bar** : Drag it horizontally to achieve the segmentation result. Do not forget to press update button. 

**Friendly reminder** : If you need help about specfic button, put your mouse on the name of button. And hang on a  few seconds and magic will show.  
![Build Status](https://github.com/lsqshr/Rivulet-Neuron-Tracing-Toolbox/blob/master/traceplot.gif)
Implementation
==============

References
==========
Rivulet paper will be avaiable soon. It can be downloaded at xxxxx.(Not available yet)
