INSERT INTO "User" (id, login, email, "firstName", "lastName", phone, bio, "createdAt", "updatedAt")
SELECT gen_random_uuid(), 'ovchinnikovpa', 'ovchinnikovpa@gmail.com', 'Павел', 'Овчинников',
       '+79017582039',
       'Full-stack веб-разработчик с 10+ лет продакшн опытом на полном стеке — от проектирования баз данных и бэкенд API до фронтенд UI и мобильных приложений.

Основной мой язык - TypeScript, но также есть выполненные задачи на Python и Java. Есть опыт с реляционными и NoSQL бд, ORM, облачными платформами, контейнеризацией и оркестрацией, CI/CD и автодеплой, системами аутентификации и авторизации, кэшированием и rate limiting, тестированием, мониторингом и observability. Работал как над продуктовыми, так и над корпоративными системами, включая сложные приложения, обрабатывающие большие объёмы данных.

Провожу техсобесы, менторю джунов, провожу код-ревью. Пишу тесты, понятную документацию, политики веток и правила линтинга. Хорошо умею выявлять проблемы на раннем этапе, используя терминал, curl, логи и нативные запросы в бд',
       now(), now()
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'ovchinnikovpa@gmail.com');

-- Links
INSERT INTO "Link" (id, "userId", label, url)
SELECT gen_random_uuid(), u.id, l.label, l.url
FROM "User" u, (VALUES
  ('LinkedIn', 'https://www.linkedin.com/in/4-life/'),
  ('GitHub', 'https://github.com/4-life')
) AS l(label, url)
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Link" WHERE "userId" = u.id);

-- Skills (flattened — schema has no category field)
INSERT INTO "Skill" (id, "userId", name)
SELECT gen_random_uuid(), u.id, s.name
FROM "User" u, (VALUES
  ('JavaScript'), ('TypeScript'), ('Python'), ('Java'), ('PHP'),
  ('React'), ('Vue.js'), ('AngularJS'), ('Sass'), ('Tailwind CSS'), ('MUI'), ('TanStack'),
  ('Next.js'), ('Node.js'), ('NestJS'), ('GraphQL'), ('Apollo'), ('Swagger'), ('TypeORM'), ('Sequelize'), ('WebSockets'),
  ('PostgreSQL'), ('Redis'), ('Database Migrations'), ('Query Optimization'),
  ('AWS'), ('GCP'), ('Docker'), ('Git'), ('Infrastructure as Code'), ('Automated Deployments'), ('GHCR'),
  ('Claude'), ('Grok'), ('Codex'), ('LangChain'), ('MCP'), ('RAG'), ('AI Agents'),
  ('Ionic'), ('Capacitor'), ('React Native'),
  ('Sentry'), ('Storybook'), ('Playwright'), ('Unit Testing'), ('Integration Testing'), ('Test Automation'), ('Linting'),
  ('Microservices'), ('Microfrontends'), ('CI/CD'), ('Serverless'), ('High-Load Systems'), ('API Design'), ('System Design'),
  ('Google Maps'), ('Mapbox'), ('SVG'), ('Charts')
) AS s(name)
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Skill" WHERE "userId" = u.id);

-- Experience: Meshintex, Inc.
INSERT INTO "Experience" (id, "userId", company, position, "startDate", "endDate", achievements)
SELECT gen_random_uuid(), u.id, 'Meshintex, Inc.', 'Fullstack-разработчик', '2026-05-01', NULL,
  ARRAY[
    'Разработал архитектуру и API для дашборда, подходящего для любых IoT-конфигураций, принимающим данные с датчиков в реальном времени, crud, с масштабируемостью до сотен тысяч подключённых сенсоров с использованием асинхронных очередей и фоновой обработки (SNS/SQS + Lambda). Дашборд показывает графики и карты в реальном времени с большим количеством маркеров с помощью MapBox. API и дашборд легко настраиваются и масштабируются под разные конфигурации сенсоров. Особый упор на безопасность.',
    'Сохранил плавность карты при большом количестве сенсоров на экране (измерялось по отсутствию лагов при панорамировании и зуме), реализовав кластеризацию маркеров.',
    'Обеспечил быструю и стабильную обработку данных при всплесках трафика с датчиков (измерялось по нулевым потерям показаний при пиках), буферизируя входящие сообщения через очередь SQS перед обработкой.',
    'Реализовал ролевую авторизацию для дашборда и API. Защитил приложение от XSS/CSRF и SSRF — санитизация/экранирование выводимых данных, валидация origin запросов, ограничение исходящих запросов с сервера.',
    'Реализовал AI-сервис на базе MCP для автоматического исправления ошибок в CI/CD. Сервис получает ошибки из Sentry и результаты неудачных тестов CI/CD, использует Claude AI API для анализа ошибок, подтягивает соответствующую документацию из Confluence и пытается сделать фикс в отдельной ветке Git. Также MCP создаёт тикеты в Jira с описанием ошибки, предложенным исправлением и ссылками на ветку и документацию. Реализованы настраиваемые лимиты повторных попыток и контроль расходов, чтобы предотвратить чрезмерное использование AI API и неконтролируемые повторные попытки. После успешного прохождения пайплайна изменения пушатся в ветку для проверки разработчиком — человек всегда остаётся ответсвенным за реквест и мерж.',
    'Также спроектировал полную архитектуру для Lambda Digital — сервиса криптоплатежей. Каждая блокчейн-сеть отслеживается своим контейнером, который подхватывает транзакции и отправляет вебхуки мерчантам — с упором на безопасность. Поверх этого работает GraphQL API на PostgreSQL. Всё работает в Docker и автоматически собирается и деплоится из единого инфраструктурного репозитория, управляющего всеми контейнерами. Разработал AI-ассистента с RAG и LangChain для помощи мерчантам с вопросами. Деплой через GHCR.',
    'Сделал каждую блокчейн-интеграцию независимо разворачиваемой и перезапускаемой, запустив отдельный контейнер-watcher для каждой сети (EVM, TRON, TON и др.), оркестрируемый из единого репозитория с health-check''ами и лимитами памяти на сервис.',
    'Обеспечил отсутствие потерь и дублирования вебхуков мерчантов под нагрузкой, вынеся отправку вебхуков в отдельный воркер на очереди BullMQ/Redis вместо прямых запросов.',
    'Оптимизировал AI-бота под ограничения бесплатного тарифа, реализовав кэширование и используя модель Grok, что снизило количество повторных запросов к API и общее потребление при сохранении отзывчивости для пользователя.'
  ]
FROM "User" u
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Experience" WHERE "userId" = u.id AND company = 'Meshintex, Inc.');

-- Experience: Kupsilla
INSERT INTO "Experience" (id, "userId", company, position, "startDate", "endDate", achievements)
SELECT gen_random_uuid(), u.id, 'Kupsilla', 'Fullstack-разработчик', '2022-07-01', '2026-05-01',
  ARRAY[
    'В Kupsilla я работал над облачной платформой автоматизации химической лаборатории и приложением для исследований генома человека.',
    'Проводил технические собеседования для junior и middle кандидатов, выполнял код-ревью и менторил разработчиков для поддержания качества кода и роста команды.',
    'Создал GraphQL boilerplate для быстрой разработки MVP любой сложности с упором на масштабируемость. Ключевая особенность — единый тип данных на typescript для всех слоёв (backend, frontend, база данных/ORM, swagger/playground).',
    'Работал с Python и Java. Хотя это не основные для меня языки, использовал их для разработки приложений, интеграций и поддержки существующих проектов.',
    'Повысил масштабируемость и независимость деплоя большой React-кодовой базы через микрофронтенды и выносом компонентов в Storybook, а так же выносом дублирующих частей кода в npm модули.',
    'Построил сложный конструктор химических реакций — тяжёлый кастомный UI-компонент, позволяющий пользователям визуально проектировать лабораторные реакции — и упаковал его в отдельный NPM-модуль.',
    'спроектировал архитектуру приложения и разработал сложные компоненты визуализации данных, способные обрабатывать большие наборы данных и рендеринг с высокой нагрузкой на данные.',
    'Построил приложение на Next.js с SSR, React, TanStack Query, TanStack Table и визуализациями на основе SVG для сервиса изучения генома человека. оптимизировал загрузку тяжелых JSON и пагинацию, оптимизировал запросы к базе данных, улучшил производительность рендеринга для сложных визуализаций.',
    'Удержал затраты на инфраструктуру AWS в рамках бесплатного тарифа (измерялось по нулевым расходам на хостинг), развернув приложение на AWS Amplify и управляя использованием build-минут в рамках бесплатной квоты.',
    'Обеспечил слаженную совместную работу команды, настроив с нуля AWS Amplify с Amazon Cognito (Google OAuth), линтинг, тестирование и политику веток GitHub'
  ]
FROM "User" u
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Experience" WHERE "userId" = u.id AND company = 'Kupsilla');

-- Experience: Strata K.K.
INSERT INTO "Experience" (id, "userId", company, position, "startDate", "endDate", achievements)
SELECT gen_random_uuid(), u.id, 'Strata K.K.', 'Fullstack-разработчик', '2021-04-01', '2022-07-01',
  ARRAY[
    'В Strata я работал над gmb.io и Praxis — платформой видеостримминга для фитнеса для западных пользователей. Стек: Next.js, NestJS, PostgreSQL, TypeORM, Auth0, AWS Lambda, MUX.',
    'Повысил качество видеопотока на широком спектре устройств (снизил буферизацию и ошибки формата), реализовав автоматическое определение платформы, которое подбирает оптимальный видеокодек и разрешение для каждого клиента, что повысило конверсию.',
    'Снизил затраты на поддержку пайплайна загрузки видео (сократил количество AWS-сервисов, необходимых для его работы), упростив микросервисную архитектуру и убрав избыточные шаги.',
    'Автоматизировал развертывание микросервисной архитектуры используя AWS CDK.'
  ]
FROM "User" u
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Experience" WHERE "userId" = u.id AND company = 'Strata K.K.');

-- Experience: Nwave
INSERT INTO "Experience" (id, "userId", company, position, "startDate", "endDate", achievements)
SELECT gen_random_uuid(), u.id, 'Nwave', 'Fullstack-разработчик', '2018-08-01', '2021-04-01',
  ARRAY[
    'В Nwave, IoT-компании, разрабатывающей умные датчики парковки для клиентов из Великобритании, я работал как Full Stack Web Developer над фронтенд- и бэкенд-системами, управляющими 20 000 IoT-устройств.',
    'Разработал REST API-сервис, обрабатывающий полный набор CRUD-операций для 20 000 устройств с покрытием тестами 99%, реализовав его на AWS Lambda, Node.js/TypeScript, PostgreSQL+PostGIS, AWS API Gateway и AWS Cognito, с тестированием через Mocha, Chai и AWS SDK.',
    'Повысил стабильность инфраструктуры и обеспечил воспроизводимые развёртывания окружений (настройка инфраструктуры одной командой), внедрив AWS CDK как infrastructure-as-code — заменив ручную настройку облака на версионируемые, воспроизводимые стеки.',
    'Улучшил производительность рендеринга 20 000 меток на карте в мобильном PWA-приложении SPlace, устранив подтормаживания на слабых устройствах, за счёт реализации кластеризации меток, устранения лишних пересчётов и оптимизации рендер-пайплайна Ionic/Angular.',
    'Также разработал и поддерживал админ-дашборд для мониторинга статусов датчиков на React, Redux-Saga, TypeScript, Material-UI, AWS Amplify и Google Maps API. Приложение имело полное покрытие unit- и end-to-end тестами, было интегрировано с Bitbucket CI/CD и Sentry.'
  ]
FROM "User" u
WHERE u.email = 'ovchinnikovpa@gmail.com'
  AND NOT EXISTS (SELECT 1 FROM "Experience" WHERE "userId" = u.id AND company = 'Nwave');
