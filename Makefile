# ============================================================
# Container
# ============================================================
.PHONY: up down
up: ## コンテナの起動
	docker compose up -d

down: ## コンテナの停止
	docker compose down


.PHONY: pg-logs pgadmin-logs
pg-logs: ## postgresのログを出力
	docker compose logs -f postgres

pgadmin-logs: ## pgadminのログを出力
	docker compose logs -f pgadmin


# ============================================================
# Database
# ============================================================
.PHONY: pg migrate-format migrate-status migrate-up migrate-push migrate-reset
pg: ## postgres dbにアクセス
	docker compose exec postgres psql -U dev -P pager=off

migrate-format: ## schema.prismaのフォーマット
	npx prisma format

migrate-status: ## 現在のマイグレーション状況を確認
	docker compose exec postgres psql -U dev -d dev -c "SELECT migration_name, logs, rolled_back_at, applied_steps_count, finished_at FROM \"_prisma_migrations\";"

migrate-up: migrate-format ## マイグレーションを実行 (ex: make migrate-up name=add_profile_image_relation)
	npx prisma migrate dev --name $(name)

migrate-push: ## schema.prisma で定義したモデルを正としてマイグレーションを実行する
	npx prisma db push

migrate-reset: ## マイグレーションのリセット（テーブルを全て削除し、一からマイグレーションを実行）
	npx prisma migrate reset

seed:
	npx prisma db seed


# ============================================================
# utilities
# ============================================================
.PHONY: help studio
help: ## ヘルプ
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

studio: ## Prisma Studio を起動
	npx prisma studio
