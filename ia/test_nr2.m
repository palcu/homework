function [] = test_ai()
%1
   x = 50*rand(2,240) - 30;
%2
   t = [];
   
   for i = 1:240
      if(x(1,i) > x(2,i))
          t(1,i) = 1;
          t(2,i) = 0;
      else
          t(1,i) = 0;
          t(2,i) = 1;
      end
   end
   %display(x(1:2,:));
   %display(3,:);
   
%3 si 4
   
   figure(1);
   plotpv(x,t);
   
   saveas(figure(1),'first.jpg');
   
   m = [];
   m(1:2,:) = x;
   m(3,:) = t(1,:);
%5

    net = newp([-30 20; -30 20], 1, 'hardlim', 'learnwh');
    net = train(net, m(1:2,:), m(3,:));
   
    figure(2);
    plotpv(m(1:2,:),  m(3,:));
    plotpc(net.IW{1,1}, net.b{1});
    
    saveas(figure(2), 'second.jpg');
end
