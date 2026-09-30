#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.loadFromModule("GameLauncher", "Main");

    if (engine.rootObjects().isEmpty())
        return EXIT_FAILURE;

    return app.exec();
}
