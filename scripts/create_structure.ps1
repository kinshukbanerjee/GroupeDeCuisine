# ==========================================================
# Groupe De Cuisine
# Flutter Project Structure Generator
# ==========================================================

$folders = @(
    "lib/core/constants",
    "lib/core/theme",
    "lib/core/widgets",
    "lib/core/services",
    "lib/core/utils",

    "lib/features/splash/presentation/screens",
    "lib/features/splash/presentation/widgets",
    "lib/features/splash/domain",
    "lib/features/splash/data",

    "lib/features/auth/presentation/screens",
    "lib/features/auth/presentation/widgets",
    "lib/features/auth/domain",
    "lib/features/auth/data",

    "lib/features/home/presentation/screens",
    "lib/features/home/presentation/widgets",
    "lib/features/home/domain",
    "lib/features/home/data",

    "lib/features/restaurant/presentation/screens",
    "lib/features/restaurant/presentation/widgets",
    "lib/features/restaurant/domain",
    "lib/features/restaurant/data",

    "lib/features/menu/presentation/screens",
    "lib/features/menu/presentation/widgets",
    "lib/features/menu/domain",
    "lib/features/menu/data",

    "lib/features/cart/presentation/screens",
    "lib/features/cart/presentation/widgets",
    "lib/features/cart/domain",
    "lib/features/cart/data",

    "lib/features/orders/presentation/screens",
    "lib/features/orders/presentation/widgets",
    "lib/features/orders/domain",
    "lib/features/orders/data",

    "lib/features/restaurant_owner/presentation/screens",
    "lib/features/restaurant_owner/presentation/widgets",
    "lib/features/restaurant_owner/domain",
    "lib/features/restaurant_owner/data",

    "lib/features/delivery_partner/presentation/screens",
    "lib/features/delivery_partner/presentation/widgets",
    "lib/features/delivery_partner/domain",
    "lib/features/delivery_partner/data",

    "lib/features/admin/presentation/screens",
    "lib/features/admin/presentation/widgets",
    "lib/features/admin/domain",
    "lib/features/admin/data",

    "lib/routes",

    "lib/shared/models",
    "lib/shared/widgets",
    "lib/shared/services",
    "lib/shared/repositories",

    "assets/images",
    "assets/icons",
    "assets/logos",
    "assets/fonts",
    "assets/animations",
    "assets/illustrations"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

Write-Host ""
Write-Host "✅ Groupe De Cuisine project structure created successfully!" -ForegroundColor Green