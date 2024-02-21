% 指定正态分布的参数
mu = 0;         % 均值
sigma = 1;      % 标准差

% 生成一组 x 值
x = linspace(-5, 5, 1000);

% 计算对应 x 值的概率密度函数值
y = normpdf(x, mu, sigma);

% 绘制正态分布图
figure;
plot(x, y, 'LineWidth', 2);
title('正态分布图');
xlabel('x');
ylabel('概率密度');

% 可选：添加均值和标准差的线
hold on;
line([mu mu], ylim, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);
line([mu-sigma mu-sigma], ylim, 'Color', 'g', 'LineStyle', '--', 'LineWidth', 2);
line([mu+sigma mu+sigma], ylim, 'Color', 'g', 'LineStyle', '--', 'LineWidth', 2);
legend('正态分布', '均值', '标准差');
hold off;


%% 测试小提琴图
X1=[1:2:7,13];
Y1=randn(100,5)+sin(X1);
X2=2:2:10;
Y2=randn(100,5)+cos(X2);

figure
Hdl1=violinChart(gca,X1,Y1,[0     0.447 0.741]);
Hdl2=violinChart(gca,X2,Y2,[0.850 0.325 0.098]);
legend([Hdl1.F_legend,Hdl2.F_legend],{'randn+sin(x)','randn+cos(x)'});
% 设置其余坐标区属性
set(gca,'AmbientLightColor',[0 0 0],'GridColor',[0 0 0],'Layer','top','box','on'); % 设置图框样式


%% 数据图_正态分布图
clc;clear

sheet_names = {'strawberry-88', 'peach-89', 'grape-84', 'pear-85', 'tomato-90', 'lettuce-101', 'cucumber-100', 'crowndaisy-100'};
ori_data = xlsread('factors_analysis_.xlsx','grape-84'); %直接用excel数据时使用

peach_cr = ori_data(:, 3:3);
peach_as = ori_data(:, 4:4);
peach_cd = ori_data(:, 5:5);
peach_pb = ori_data(:, 6:6);


%绘图
% 创建子图，绘制四个指标的频率分布图
figure
subplot(2, 2, 1);
%histogram(peach_cr, 'BinMethod', 'auto');
histfit(peach_cr, 10, 'normal', 'FaceColor', 'none');
ylabel('Cr frequency');
xlabel('mg/kg')
hold on
mean_cr = mean(peach_cr);
std_cr = std(peach_cr);
plot([mean_cr, mean_cr], ylim, 'k-.', 'LineWidth', 2); % 平均值线
plot([mean_cr - std_cr, mean_cr - std_cr], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线
plot([mean_cr + std_cr, mean_cr + std_cr], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线
xlim([0, max(peach_cr)]);
title('peach\_cr Frequency Distribution');
%legend('Histogram', 'Normal Fit');

subplot(2, 2, 2);
%histogram(peach_as, 'BinMethod', 'auto');
histfit(peach_as, 10, 'normal', 'FaceColor', [0.2 0.8 0.2]);
ylabel('As frequency');
xlabel('mg/kg')
hold on
mean_as = nanmean(peach_as);
std_as = nanstd(peach_as);

plot([mean_as, mean_as], ylim, 'k-.', 'LineWidth', 2); % 平均值线
plot([mean_as - std_as, mean_as - std_as], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线
plot([mean_as + std_as, mean_as + std_as], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线
xlim([0, max(peach_as)]);
title('peach\_as Frequency Distribution');

subplot(2, 2, 3);
%histogram(peach_cd, 'BinMethod', 'auto');
histfit(peach_cd, 10, 'normal', 'FaceColor', [0.2 0.2 0.8]);
ylabel('Cd frequency');
xlabel('mg/kg')
hold on
mean_cd = mean(peach_cd);
std_cd = std(peach_cd);
plot([mean_cd, mean_cd], ylim, 'k-.', 'LineWidth', 2); % 平均值线
plot([mean_cd - std_cd, mean_cd - std_cd], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线
plot([mean_cd + std_cd, mean_cd + std_cd], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线

xlim([0, max(peach_cd)]);
title('peach\_cd Frequency Distribution');

subplot(2, 2, 4);
%histogram(peach_pb, 'BinMethod', 'auto');
histfit(peach_pb, 10, 'normal', 'FaceColor', [0.8 0.8 0.2]);
ylabel('Pb frequency');
xlabel('mg/kg')
hold on
mean_pb = mean(peach_pb);
std_pb = std(peach_pb);
plot([mean_pb, mean_pb], ylim, 'k-.', 'LineWidth', 2); % 平均值线
plot([mean_pb - std_pb, mean_pb - std_pb], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线
plot([mean_pb + std_pb, mean_pb + std_pb], ylim, 'g--', 'LineWidth', 2); % 一倍标准偏差线

xlim([0, max(peach_pb)]);
title('peach\_pb Frequency Distribution');

%% 数据图_for循环简化代码
%
clc;clear

sheet_names = {'strawberry-88', 'peach-89', 'grape-84', 'pear-85', 'tomato-90', 'lettuce-101', 'cucumber-100', 'crowndaisy-100'}; %构造一个sheet名称列表
title_names = {'Strawberry', 'Peach', 'Grape', 'Pear', 'Tomato', 'Lettuce', 'Cucumber', 'Crowndaisy'}; %构造sheet名称传递到title的名称列表

% 指标名称和数据对应关系
indicators = {'Cr', 'As', 'Cd', 'Pb'};
data_columns = [3, 4, 5, 6];
set(0, 'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontSize', 11, 'DefaultAxesFontWeight', 'bold');

% 绘图
for sheet_idx = 1:length(sheet_names); % 建立sheet列表
    sheet_name_i = sheet_names{sheet_idx}; % sheet列表转换
    ori_data = xlsread('factors_analysis_.xlsx', sheet_name_i); %循环读取xls的sheet

    figure;

    for k = 1:length(indicators) % 建立画图序列
        subplot(2, 2, k);

        % 提取当前指标的数据列
        current_data = ori_data(:, data_columns(k)); % 标题名称

        % 绘制直方图和正态分布曲线
        h = histfit(current_data, 10, 'normal', 'FaceColor', 'none');
        ylabel([indicators{k}, ' frequency/', ' %']);
        xlabel('mg/kg');

        get(h(1));
        x1=get(h(1),'XData');

        % 计算均值和标准差
        mean_val = nanmean(current_data); %处理有缺失值的数据
        std_val = nanstd(current_data); %处理有缺失值的数据
        % 计算置信区间边界
        alpha = 0.05;  % 置信水平为 95%
        n = length(current_data);  % 数据点数
        z_critical = norminv(1 - alpha / 2, 0, 1);  % 正态分布的临界值

        % 计算置信区间
        lower_bound = mean_val - z_critical * (std_val / sqrt(n));
        upper_bound = mean_val + z_critical * (std_val / sqrt(n));

        % 绘制均值线和一倍标准偏差线
        hold on;

        h1 = plot([mean_val, mean_val], ylim, 'k-.', 'LineWidth', 2); % 平均值线
        %h2 = plot([lower_bound, lower_bound], ylim, 'color', [0, 0.7, 0], 'Linestyle', '--', 'LineWidth', 2); % 95置信区间
        %h3 = plot([upper_bound, upper_bound], ylim, 'color', [0, 0.7, 0], 'Linestyle', '--', 'LineWidth', 2); % 95置信区间

        h2 = plot([mean_val+std_val, mean_val+std_val], ylim, 'color', [0, 0.7, 0], 'Linestyle', '--', 'LineWidth', 2); % 一倍标准偏差线
        h3 = plot([mean_val-std_val, mean_val-std_val], ylim, 'color', [0, 0.7, 0], 'Linestyle', '--', 'LineWidth', 2); % 一倍标准偏差线
        hold on

        get(h(1));
        x1=get(h(1),'XData');
        y1=get(h(1),'YData');

        hold on %开始抓取柱图数据添加末端标签
        b = bar(x1, y1,'FaceColor','none','EdgeColor','none');
        xtips1 = b.XEndPoints;
        ytips1 = b.YEndPoints;
        labels1 = string(b.YData);
        text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
            'VerticalAlignment','bottom', 'Fontname', 'Times New Roman');

        xlim([0, 1.1*max(current_data)]); %设置x最大值
        ylim([0, 1.5*max(y1)]); %设置x最大值

        title({[title_names{sheet_idx},'\_', indicators{k}, ' Frequency Distribution']; ' '}, 'FontWeight', 'bold');
        hold off;

        %添加图例
        legend([h1, h2], ...
            ['Mean: ', sprintf('%.3f', mean_val)], ...
            ['Mean ± 1 σ: [', sprintf('%.3f', max(mean_val - std_val, 0)), ', ', sprintf('%.3f', mean_val + std_val), ']'], ...
            'location', 'Northeast', 'Fontname', 'Times New Roman', 'FontWeight', 'bold', 'FontSize', 10);
        legend('boxoff'); %去除图例的背景
    end
    set(gcf,'unit','centimeters','position',[1 2 21 18]) %调整图像窗口大小位置
end

